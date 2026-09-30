#!/usr/bin/env bash
# (임시) 학교밖청소년지원센터(꿈드림) 1차: 센터 목록·홈페이지 이전 안내·상담센터 누리집 안 꿈드림 메뉴
f() { python scripts/dev_fetch.py "$@" || true; }
f kyci_move "https://www.kyci.or.kr/boardManagement/board.asp?board_menu=view&boIdx=7311&rowNumber=1&page=1&nselect=1&bid=bid_1&menuCategory=5"
f kyci_dream "https://www.kyci.or.kr/userSite/dreamLocalManagement/list.asp?basicNum=1"
f kdream_local "http://kdream.or.kr/dreamLocalManagement/list.asp?basicNum=6"
f kdream_main "https://www.kdream.or.kr/"
f cando_dream "http://www.cando.or.kr/school_program/school_program01.php"
f junggu_dream "https://www.bsjunggu.go.kr/welfare/index.junggu?menuCd=DOM_000000404009000000"
f namgu_dream "https://www.namgu1388.kr/ggumdream"
f saha_dream "https://saha1388.kr/dream/dream_introduction.php"
f udream_main "http://u-dream.or.kr/"
f meetyou_kkum "http://meetyou.kr/kkum/dream/"
f yeonje_main "https://www.yeonje1388.or.kr/"
f gjyouth_main "https://www.gjyouth1388.or.kr/"
f bukgu_youth "https://www.bsbukgu.go.kr/youth/index.bsbukgu"
