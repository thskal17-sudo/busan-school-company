#!/usr/bin/env bash
# (임시) 청소년수련관 게시판 조사 2차: 시설 목록(수련관·수련원·문화의집) 전체 + 알려진 홈페이지
f() { python scripts/dev_fetch.py "$@" || true; }
for p in 1 2 3 4; do f "dir_all_$p" "https://www.busanyouth.net/sub/template.php?midx=55&page=$p"; done
f dir_suryeon "https://www.busanyouth.net/sub/template.php?midx=55&key1=&key2=%EC%B2%AD%EC%86%8C%EB%85%84%EC%88%98%EB%A0%A8%EA%B4%80"
f youthcool_http "http://www.youthcool.or.kr/"
f gj_youth "http://www.gijangcmc.or.kr/youth/main/main.asp"
f onnainna "https://onnainna.kr/"
f gaya "http://gayayouth.or.kr/"
