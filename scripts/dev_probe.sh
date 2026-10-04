#!/usr/bin/env bash
# (임시) 아동보호전문기관 게시판 조사 1차: 누리집·robots.txt
f() { python scripts/dev_fetch.py "$@" || true; }
for h in dbchild.saem.or.kr busansb.goodneighbors.kr bnc1391.or.kr jbusan1391.or.kr bsjin1391.or.kr; do
  n=${h%%.*}
  f "robots_$n" "https://$h/robots.txt"
  f "home_$n" "https://$h/"
done
f home_dbchild_http "http://dbchild.saem.or.kr/"
f home_bnc_http "http://bnc1391.or.kr/"
f home_jbusan_http "http://jbusan1391.or.kr/"
f bsjin_zone "https://bsjin1391.or.kr/zone"
f adong "https://www.busan.go.kr/adong/index"
