# 초등방과후돌봄통합플랫폼 구조 확인
P="--proxy $KR_PROXY_URL"
f() { echo "== $1 -> $2"; curl -sS -L -m 40 $P -A "Mozilla/5.0 (busan-jobs notifier)" -o "$2" -w "%{http_code} %{url_effective}\n" "$1"; }
f https://home.pen.go.kr/robots.txt robots.txt; cat robots.txt
f https://home.pen.go.kr/aftersc/main.do main.html
grep -o 'href="[^"]*"' main.html | sort -u | head -150
