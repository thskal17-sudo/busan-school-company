#!/usr/bin/env bash
# (임시) 종합사회복지관 6차: 남은 게시판
f() { python scripts/dev_fetch.py "$@" || true; }
f c05n "http://www.gamman.or.kr/05_Community/01_impartation.php"
f c19n "http://hwajung.saem.or.kr/community/news.php"
f c46n "http://haeundae.saem.or.kr/community/news.php"
f c45n "https://www.yjswc.or.kr/toktok/toktok01.php"
f c45h "https://www.yjswc.or.kr/toktok/toktok05.php"
f c02g "https://www.ndswc.or.kr/06/01.php?mode=list_ok&skind=&skey=&search=&page=1"
f c02p "https://www.ndswc.or.kr/06/01.php?mode=list_ok&skind=&skey=&search=&page=1" "post:page=1"
f c29g "https://www.sahabokji.or.kr/05/01.php?mode=list_ok&skind=&skey=&search=&page=1"
f c29p "https://www.sahabokji.or.kr/05/01.php?mode=list_ok&skind=&skey=&search=&page=1" "post:page=1"
f c34m "http://lovesw.or.kr/" ua
