#!/usr/bin/env bash
# (임시) 청소년 기관 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }

f say_busan "http://www.bsycsay.or.kr/"
f say_busan_s "https://www.bsycsay.or.kr/"
f say_2008 "http://2008say.or.kr/"
f onestop "http://www.busanonestop.or.kr/"
f bsyc "http://www.bsyc.or.kr/"
f bsdi "http://bsdi.or.kr/"
f jarip "http://www.bsyjarip.or.kr/"
f shelter "http://www.shelter1004.org/"
f bsyouth_assoc "http://bsyouth.or.kr/"
f bsyouth_assoc_list "http://bsyouth.or.kr/sub14.php"
f bomul "http://bomulsangja.com/"
f sangsang "https://www.busanyouth.net/sub/template.php?midx=168"
f yeje "http://www.gijangcmc.or.kr/gcdyc/main/main.asp"
f arpina "http://www.arpina.co.kr/"
