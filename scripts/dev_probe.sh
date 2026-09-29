#!/usr/bin/env bash
# (임시) 청소년수련관 게시판 조사 4차: 금곡·사상·구덕·함지골
f() { python scripts/dev_fetch.py "$@" || true; }
f kg_notice "http://kum-gok.or.kr/p41.php"
f yz_notice "https://www.yzzang.com/sb51.php"
f yz_hire "https://www.yzzang.com/sb55.php"
f gudeok_new "http://gudeok.or.kr/"
f gudeok_new_s "https://gudeok.or.kr/"
f hamji_main "http://www.hamji.or.kr/skin_build61/index.php"
