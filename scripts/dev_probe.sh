#!/usr/bin/env bash
# (임시) 수집 서버에서 사이트별 연결(TCP+TLS) 시간 측정 — 연결 대기 시간을 얼마로 줄일지 정하려고.
python - <<'PY'
import socket, ssl, time, certifi
from concurrent.futures import ThreadPoolExecutor
from urllib.parse import urlsplit
from busan_jobs.config import load_settings

hosts = {}
for s in load_settings().sources:
    if s.enabled and s.url:
        u = urlsplit(s.url)
        key = (u.scheme, u.hostname, u.port or (443 if u.scheme == "https" else 80))
        hosts[key] = hosts.get(key, False) or bool(s.options.get("legacy_tls"))

def ctx_for(legacy):
    ctx = ssl.create_default_context(cafile=certifi.where())
    if legacy:
        ctx.set_ciphers("DEFAULT:@SECLEVEL=0")
        ctx.minimum_version = ssl.TLSVersion.TLSv1
        ctx.options |= getattr(ssl, "OP_LEGACY_SERVER_CONNECT", 0x4)
    return ctx

def once(scheme, host, port, legacy):
    t0 = time.monotonic()
    try:
        socket.getaddrinfo(host, port, type=socket.SOCK_STREAM)
    except OSError as e:
        return ("dns_fail", time.monotonic() - t0, 0, 0, type(e).__name__)
    t1 = time.monotonic()
    try:
        sock = socket.create_connection((host, port), timeout=20)
    except OSError as e:
        return ("tcp_fail", t1 - t0, time.monotonic() - t1, 0, type(e).__name__)
    t2 = time.monotonic()
    note = ""
    if scheme == "https":
        try:
            sock.settimeout(20)
            sock = ctx_for(legacy).wrap_socket(sock, server_hostname=host)
        except (OSError, ssl.SSLError) as e:  # 인증서 체인 미비 등은 핸드셰이크 시간만 본다
            note = type(e).__name__
    t3 = time.monotonic()
    sock.close()
    return ("ok", t1 - t0, t2 - t1, t3 - t2, note)

def measure(item):
    (scheme, host, port), legacy = item
    rows = []
    for _ in range(3):
        rows.append(once(scheme, host, port, legacy))
        time.sleep(0.5)
    return host, port, legacy, rows

with ThreadPoolExecutor(12) as ex:
    results = list(ex.map(measure, hosts.items()))

with open("probe_out/connect.tsv", "w") as f:
    for host, port, legacy, rows in results:
        for st, dns, tcp, tls, note in rows:
            f.write(f"{host}\t{port}\t{int(legacy)}\t{st}\t{dns:.2f}\t{tcp:.2f}\t{tls:.2f}\t{note}\n")
print("hosts", len(results))
PY
