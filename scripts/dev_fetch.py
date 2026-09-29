"""(임시) 목록 페이지를 받아 probe_out/<이름>.html 로 저장하고 게시판 파서 결과를 짧게 보여준다.

    python scripts/dev_fetch.py 이름 URL [legacy] [post:a=1&b=2]
"""
from __future__ import annotations

import sys
from pathlib import Path
from urllib.parse import parse_qsl, urlsplit

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "src"))

from busan_jobs.collectors.board import parse_board  # noqa: E402
from busan_jobs.http import Http  # noqa: E402
from busan_jobs.models import today_kst  # noqa: E402

http = Http(min_interval=0.5, retries=0, max_seconds=40)
out = ROOT / "probe_out"
out.mkdir(exist_ok=True)
name, url, *rest = sys.argv[1:]
if "legacy" in rest:
    http.allow_legacy_tls(urlsplit(url).hostname or "")
if "ua" in rest:  # 봇 표시 없는 일반 브라우저 User-Agent
    http.session.headers["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0 Safari/537.36"
if "noal" in rest:
    http.session.headers.pop("Accept-Language", None)
post = next((r[5:] for r in rest if r.startswith("post:")), None)
try:
    if post is not None:
        resp = http.post(url, data=dict(parse_qsl(post, keep_blank_values=True)))
    else:
        resp = http.get(url)
except Exception as exc:  # noqa: BLE001
    resp = getattr(exc, "response", None)
    if resp is None:
        print(f"[{name}] ERROR {type(exc).__name__}: {str(exc)[:300]}")
        sys.exit(0)
(out / f"{name}.html").write_bytes(resp.content)
rows = parse_board(resp.content, resp.url, {}, today_kst())
print(f"[{name}] {resp.status_code} {len(resp.content)}B rows={len(rows)} final={resp.url}")
for r in rows[:4]:
    print(f"    · {r.title[:60]!r} posted={r.posted} org={r.org!r} ok={r.detail_ok} url={r.url[:160]}")
