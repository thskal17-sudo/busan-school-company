#!/usr/bin/env bash
# (임시) 다문화가족지원센터(가족센터) 게시판 조사 2차: 다누리 센터 페이지, 한국어교원 구인정보
f() { python scripts/dev_fetch.py "$@" || true; }
curl -s -m 20 -o probe_out/robots_danuri.txt -w "[robots_danuri] %{http_code} %{size_download}B\n" https://www.liveinkorea.kr/robots.txt || true
curl -s -m 20 -o probe_out/robots_kteacher.txt -w "[robots_kteacher] %{http_code} %{size_download}B\n" https://kteacher.korean.go.kr/robots.txt || true
f dn_board_26 "https://www.liveinkorea.kr/center/board/mlrc/boardList.do?menuSeq=174&boardSeq=28&centerSeq=26"
f dn_board_32 "https://www.liveinkorea.kr/center/board/mlrc/boardList.do?menuSeq=174&boardSeq=28&centerSeq=32"
for s in busanseogu busandonggu yeongdo busanjin dongraegu busannamgu busanbukgu haeundae saha gjfc yeonje suyeong sasang gijang; do
  f "dn_main_$s" "https://www.liveinkorea.kr/center/main/main.do?centerId=$s"
done
f kt_list "https://kteacher.korean.go.kr/jobsearch/list"
f kt_busan "https://kteacher.korean.go.kr/jobsearch/list?grp=&searchType=&keyword=%EB%B6%80%EC%82%B0&pageNo=1"
