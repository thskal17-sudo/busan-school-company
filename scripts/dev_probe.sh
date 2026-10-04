#!/usr/bin/env bash
# (임시) 다문화가족지원센터(가족센터) 게시판 조사 1차
f() { python scripts/dev_fetch.py "$@" || true; }
curl -s -m 20 -o probe_out/robots_familynet.txt -w "[robots] %{http_code} %{size_download}B\n" https://busanseogu.familynet.or.kr/robots.txt || true
curl -s -m 20 -o probe_out/robots_www.txt -w "[robots_www] %{http_code} %{size_download}B\n" https://www.familynet.or.kr/robots.txt || true
for s in busanseogu busandonggu yeongdo busanjin dongraegu busannamgu busanbukgu haeundae saha gjfc yeonje suyeong sasang gijang bsfc busangangseo gangseo busanjunggu junggu namgu bukgu busanjingu; do
  f "home_$s" "https://$s.familynet.or.kr/center/index.do"
  f "nt_$s" "https://$s.familynet.or.kr/center/lay1/bbs/S295T311C312/A/6/list.do"
  f "hr_$s" "https://$s.familynet.or.kr/center/lay1/bbs/S295T311C313/A/7/list.do"
done
