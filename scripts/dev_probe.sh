# 초등방과후돌봄통합플랫폼 게시판 확인 (2)
P="--proxy $KR_PROXY_URL"
f() { curl -sS -L -m 40 $P -A "Mozilla/5.0 (busan-jobs notifier)" -o "$2" -w "%{http_code} $1\n" "$1"; }
f https://home.pen.go.kr/aftersc/main.do main.html
echo "--- 메뉴"; python3 - <<'PY'
import re,html
s=open("main.html",encoding="utf-8",errors="replace").read()
for m in re.finditer(r'<a[^>]*href="(/aftersc/na/ntt/selectNttList\.do\?mi=(\d+)&(?:amp;)?bbsId=(\d+))"[^>]*>(.*?)</a>',s,re.S):
    t=re.sub(r"<[^>]+>|\s+"," ",m.group(4)).strip()
    print(m.group(2),m.group(3),html.unescape(t))
PY
for mb in 18388:5552 18390:5553 18398:5559 18316:x 18392:5558 18399:5560 18400:5561 18391:5554; do
  mi=${mb%%:*}; b=${mb##*:}
  if [ "$b" = x ]; then u="https://home.pen.go.kr/aftersc/na/ntt/selectNttList.do?mi=$mi"; else u="https://home.pen.go.kr/aftersc/na/ntt/selectNttList.do?mi=$mi&bbsId=$b"; fi
  echo; echo "=== $u"; f "$u" l_$mi.html
  python3 - l_$mi.html <<'PY'
import re,sys,html
s=open(sys.argv[1],encoding="utf-8",errors="replace").read()
t=re.search(r"<title>(.*?)</title>",s,re.S); print("title:",t and html.unescape(t.group(1).strip()))
rows=re.findall(r"<tr[^>]*>(.*?)</tr>",s,re.S)
for r in rows[:8]:
    print(" |",re.sub(r"\s+"," ",html.unescape(re.sub(r"<[^>]+>"," ",r))).strip()[:200])
a=re.findall(r'<a[^>]*(?:href|onclick|data-id)="[^"]*"[^>]*>',s)
for x in [x for x in a if "ntt" in x.lower() or "Info" in x][:4]: print(" a:",x[:250])
PY
done
