#!/usr/bin/env bash
# (임시) 부산시청 서버(www.busan.go.kr) 접속 재확인 + 여성문화회관 공지
f() { python scripts/dev_fetch.py "$@" || true; }

curl -s -o /dev/null -m 20 -w "busan.go.kr https %{http_code} %{time_total}s\n" https://www.busan.go.kr/ || echo "busan.go.kr https 실패"
curl -s -o /dev/null -m 20 -w "busan.go.kr http %{http_code} %{time_total}s\n" http://www.busan.go.kr/ || echo "busan.go.kr http 실패"
f wcc_home "https://www.busan.go.kr/wcc/index"
f wcc_notice "https://www.busan.go.kr/wcc/wcnotice"
f woman_invite "https://www.busan.go.kr/woman/whinvitation"
python -m busan_jobs check-source city_jobs womenhall_notice > probe_out/check.txt 2>&1 || true
