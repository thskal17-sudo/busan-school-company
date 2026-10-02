#!/usr/bin/env bash
# (임시) 종합사회복지관 7차: 남은 게시판과 상세 주소 확인
f() { python scripts/dev_fetch.py "$@" || true; }
f d02v "https://www.ndswc.or.kr/06/01.php?mode=view&uid=1437"
f d29v "https://www.sahabokji.or.kr/05/01.php?mode=view&uid=868"
f d19n "http://hwajung.saem.or.kr/community/news1.php"
f d46n "http://haeundae.saem.or.kr/community/news1.php"
f d45n "https://www.yjswc.or.kr/renewal/toktok/toktok01.php"
f d45h "https://www.yjswc.or.kr/renewal/toktok/toktok05.php"
