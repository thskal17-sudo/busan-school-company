#!/usr/bin/env bash
# (임시) 다문화가족지원센터(가족센터) 게시판 조사 3차: 다누리 지역 목록, 상세, robots
f() { python scripts/dev_fetch.py "$@" || true; }
B=https://www.liveinkorea.kr/center/lay1/bbs
f robots_dn "https://www.liveinkorea.kr/robots.txt"
f robots_kt "https://kteacher.korean.go.kr/robots.txt"
f dn_area "$B/S8T53C63/A/6/list.do?area=A002"
f dn_area_d "$B/S8T53C63/A/6/list.do?area=A002&area_detail=D033"
f dn_view "$B/S8T53C63/A/6/view.do?article_seq=167086"
f dn_bv "https://www.liveinkorea.kr/center/board/mlrc/boardView.do?menuSeq=174&boardSeq=28&conSeq=453349&centerSeq=26"
f dn_notice_area "$B/S8T53C62/A/16/list.do?area=A002"
f dn_web "https://www.liveinkorea.kr/web/index.do"
f kt_p2 "https://kteacher.korean.go.kr/jobsearch/list?grp=&searchType=&keyword=&pageNo=2"
f kt_view "https://kteacher.korean.go.kr/jobsearch/34982"
