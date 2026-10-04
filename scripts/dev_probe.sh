#!/usr/bin/env bash
# (임시) 육아종합지원센터 게시판 조사 4차: 시험 수집 + 북구·동래·강서 공지
f() { python scripts/dev_fetch.py "$@" || true; }
for b in 0001 0002 0003; do
  f "bbg_$b" "https://www.bbgscc.or.kr/board/list.asp?BoardID=$b"
  f "bds_$b" "https://www.bdscc.or.kr/board/list.asp?BoardID=$b"
  f "bgs_$b" "http://www.bgscc.or.kr/board/list.asp?BoardID=$b"
done
f robots_bgs "http://www.bgscc.or.kr/robots.txt"
f robots_bds "https://www.bdscc.or.kr/robots.txt"
python -m busan_jobs check-source childcare_busan_notice childcare_busan_gu_hire childcare_sasang_notice childcare_suyeong_notice childcare_seogu_notice childcare_geumjeong_notice childcare_saha_notice childcare_yeongdo_notice childcare_gijang_notice childcare_busanjin_notice > probe_out/check.txt 2>&1 || true
grep -E "^===|목록|오류" probe_out/check.txt
