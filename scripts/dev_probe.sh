#!/usr/bin/env bash
# (임시) 수영장 2차: 채용 게시판 목록
f() { python scripts/dev_fetch.py "$@" || true; }
f l_spo1_not "https://www.spo1.or.kr/bbs/list.do?cmd=list&CT_ID=NOTICE&NOGUBUN=S"
f l_spo1_rec "https://www.spo1.or.kr/bbs/list.do?cmd=list&CT_ID=RECRUIT"
f l_spo1_rec2 "https://www.spo1.or.kr/bbs/list.do?cmd=list&CT_ID=RECRUIT&NOGUBUN="
f l_dgart_h "https://www.bsdgsportsart.or.kr/www/61"
f l_ssnsc_h "https://www.ssnsc.or.kr/board_inc/sub06.asp"
f l_sgsport_n "http://www.sgsport.co.kr/bbs/news"
f m_ydsports "http://www.ydsports.org/"
f m_gssports "https://www.gssports.or.kr/"
