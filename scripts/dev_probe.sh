#!/usr/bin/env bash
# (임시) 장난감도서관 게시판 조사 2차: 동래 맘스허그, 부산시 센터 시설이용(bcsc.kr)
f() { python scripts/dev_fetch.py "$@" || true; }
f bds_toy11 "https://www.bdscc.or.kr/toy/board/list.asp?BoardID=0011"
f bds_toy12 "https://www.bdscc.or.kr/toy/board/list.asp?BoardID=0012"
f robots_bcsc "https://www.bcsc.kr/robots.txt"
f bcsc_home "https://www.bcsc.kr/"
f bcsc_toy "http://www.bcsc.kr/2015/02/01.php"
f bcsc_0203 "https://www.bcsc.kr/2015/04/02_03.php"
