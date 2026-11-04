P="--proxy $KR_PROXY_URL"
f() { echo "== $1"; curl -sS -L -m 40 $P -A "Mozilla/5.0 (busan-jobs notifier)" -o "$2" -w "%{http_code} %{url_effective}\n" "$1"; }
f https://www.busan.go.kr/robots.txt robots.txt; head -40 robots.txt
f https://www.busan.go.kr/depart/jobgonji01 list.html
grep -n -i "1759885" list.html | head; echo; grep -o '<a[^>]*jobgonji01[^>]*>' list.html | head -20
grep -n -i -B3 -A3 "goView\|fn_view\|onclick" list.html | head -40
f https://www.busan.go.kr/depart/jobgonji01/1759885 d1.html; grep -o "<title>[^<]*" d1.html; grep -c "1759885" d1.html
f "https://www.busan.go.kr/depart/jobgonji01/view?dataNo=1759885" d2.html; grep -o "<title>[^<]*" d2.html
