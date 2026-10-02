#!/usr/bin/env bash
# (임시) 체육센터 4차: 남은 게시판 목록
f() { python scripts/dev_fetch.py "$@" || true; }
f a_bbsc_n "https://bbsc.kr/board/notice"
f a_yd_n "https://yd7330.com/board/list/notice"
f a_yd_h "https://yd7330.com/board/list/employment"
f a_hud_n "http://www.hud7330.com/bbs/board.php?bo_table=notice"
f a_hud_h "http://www.hud7330.com/bbs/board.php?bo_table=employment"
f c_yj_n "https://www.yj-sports.or.kr/bbs/board.php?bo_table=05_01"
f c_yj_h "https://www.yj-sports.or.kr/bbs/board.php?bo_table=05_03"
f c_sy_h "https://www.sysports.or.kr/emSolution/board/recru"
f c_gj_n "https://www.gjsports.go.kr/bbs/board.php?bo_table=05_01"
