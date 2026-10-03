#!/usr/bin/env bash
# (임시) 청소년 기관 게시판 조사 2차
f() { python scripts/dev_fetch.py "$@" || true; }

f say_notice "http://www.bsycsay.or.kr/bbs/board"
f onestop_notice "http://www.busanonestop.or.kr/bbs/rwdboard"
f jarip_notice "http://www.bsyjarip.or.kr/bbs/notice"
f bsyc_notice "http://www.bsyc.or.kr/sub06/sub06_01.php"
f assoc_hire "http://bsyouth.or.kr/sub31.php"
f assoc_notice "http://bsyouth.or.kr/sub41.php"
f bomul_news "http://bomulsangja.com/ntbd1"
f say_s_robots "http://www.bsycsay.or.kr/robots.txt"
