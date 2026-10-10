#!/usr/bin/env bash
# (임시) 접속 안 되는 사이트 원인 진단: DNS·TCP·HTTP 응답, IP 소유자, 다른 나라 점검 노드 결과
set +e
O=probe_out
sudo apt-get install -y -qq dnsutils traceroute >/dev/null 2>&1
HOSTS="www.haeundae.go.kr eminwon.haeundae.go.kr www.jsswc.or.kr www.xn--hk3bqct1u.kr www.seogucc.or.kr www.yjsilver.com lifelong.deu.ac.kr ojin.saem.or.kr www.busan.go.kr"
{
for h in $HOSTS; do
  echo "=== $h"
  for ns in "" @8.8.8.8 @1.1.1.1 @9.9.9.9; do
    echo "  dig $ns: $(dig +short +time=4 +tries=1 A $h $ns | tr '\n' ' ')"
  done
done
echo "=== haeundae.go.kr NS / SOA"
dig +time=4 +tries=1 NS haeundae.go.kr @8.8.8.8 | grep -v '^;\|^$'
dig +time=4 +tries=1 SOA haeundae.go.kr @8.8.8.8 | grep -E 'status|SOA'
echo "=== go.kr 위임 (권한 서버에 직접)"
dig +norec +time=4 +tries=1 NS haeundae.go.kr @$(dig +short NS go.kr @8.8.8.8 | head -1) | grep -v '^;\|^$'
for ns in $(dig +norec +short +time=4 +tries=1 NS haeundae.go.kr @$(dig +short NS go.kr @8.8.8.8 | head -1) | sort -u); do
  echo "  권한서버 $ns ($(dig +short A $ns @8.8.8.8 | tr '\n' ' ')): $(dig +norec +time=4 +tries=1 +short A www.haeundae.go.kr @$ns 2>&1 | tr '\n' ' ')"
done
echo "=== dig +trace www.haeundae.go.kr"
dig +trace +time=4 +tries=1 A www.haeundae.go.kr | tail -25
} > $O/dns.txt 2>&1

{
for h in www.jsswc.or.kr www.xn--hk3bqct1u.kr www.seogucc.or.kr www.yjsilver.com lifelong.deu.ac.kr; do
  ip=$(dig +short A $h @8.8.8.8 | grep -E '^[0-9.]+$' | tail -1)
  echo "=== $h -> $ip"
  [ -z "$ip" ] && continue
  curl -s -m 15 "https://rdap.apnic.net/ip/$ip" | python3 -c 'import json,sys
d=json.load(sys.stdin); print("  소유:", d.get("name"), "|", d.get("country"), "|", " / ".join(r.get("description",[""])[0] for r in d.get("remarks",[])[:2]))' 2>&1
  for p in 80 443; do
    t0=$(date +%s.%N); timeout 8 bash -c "exec 3<>/dev/tcp/$ip/$p" 2>/dev/null; rc=$?; t1=$(date +%s.%N)
    echo "  tcp $p: rc=$rc ($(python3 -c "print(round($t1-$t0,1))")s)"
  done
  echo "  traceroute -T 443:"; sudo traceroute -T -p 443 -q 1 -w 2 -m 25 -n $ip 2>&1 | tail -8 | sed 's/^/    /'
done
} > $O/tcp.txt 2>&1

{
for u in "https://lifelong.deu.ac.kr/Board/BoardList.aspx?MENU_ID=146&PAGE_NO=&BoardMstNo=1" "https://lifelong.deu.ac.kr/" "https://www.deu.ac.kr/"; do
  echo "=== $u"
  curl -sS -m 30 -o $O/body.tmp -D - -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0 Safari/537.36 BusanInstructorJobs/1.0" "$u" | head -20
  echo "--- body:"; head -c 1500 $O/body.tmp | sed 's/<[^>]*>/ /g' | tr -s ' \n' | head -c 800; echo
done
rm -f $O/body.tmp
} > $O/deu.txt 2>&1

# 다른 나라 점검 노드(check-host.net)에서 TCP 접속되는지 — 첫 번째 러너만
if [ "$ATTEMPT" = 1 ]; then
{
for t in www.haeundae.go.kr:443 www.jsswc.or.kr:443 www.xn--hk3bqct1u.kr:80 lifelong.deu.ac.kr:443; do
  echo "=== $t"
  id=$(curl -s -m 20 -H 'Accept: application/json' "https://check-host.net/check-tcp?host=$t&max_nodes=60" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["request_id"]); json.dump(d["nodes"], open("/tmp/nodes.json","w"))')
  sleep 25
  curl -s -m 20 -H 'Accept: application/json' "https://check-host.net/check-result/$id" | python3 -c 'import json,sys
r=json.load(sys.stdin); n=json.load(open("/tmp/nodes.json"))
for k,v in sorted(r.items(), key=lambda x: n.get(x[0],[""])[0]):
    c=n.get(k,["?","?","?"]); 
    st="대기" if v is None else ("OK %.2fs" % v[0]["time"] if v and isinstance(v[0],dict) and "time" in v[0] else str(v)[:60])
    print("  %s %s %s: %s" % (c[0], c[1], c[2], st))'
done
for h in www.haeundae.go.kr; do
  echo "=== dns $h"
  id=$(curl -s -m 20 -H 'Accept: application/json' "https://check-host.net/check-dns?host=$h&max_nodes=60" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["request_id"]); json.dump(d["nodes"], open("/tmp/nodes.json","w"))')
  sleep 20
  curl -s -m 20 -H 'Accept: application/json' "https://check-host.net/check-result/$id" | python3 -c 'import json,sys
r=json.load(sys.stdin); n=json.load(open("/tmp/nodes.json"))
for k,v in sorted(r.items(), key=lambda x: n.get(x[0],[""])[0]):
    c=n.get(k,["?","?","?"]); print("  %s %s %s: %s" % (c[0], c[1], c[2], str(v)[:80]))'
done
} > $O/checkhost.txt 2>&1
fi
curl -s -m 10 https://ipinfo.io/json > $O/runner.json
ls -la $O
