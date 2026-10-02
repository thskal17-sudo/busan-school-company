#!/usr/bin/env bash
# (임시) 수영장 1차: 수영장 있는 체육센터 첫 화면·채용 게시판
f() { python scripts/dev_fetch.py "$@" || true; }
f m_spo1 "https://www.spo1.or.kr/"
f l_spo1_rec "https://www.spo1.or.kr/bbs/list.do?CT_ID=RECRUIT"
f l_spo1_not "https://www.spo1.or.kr/bbs/list.do?CT_ID=NOTICE"
f l_spo1_mrec "https://m.spo1.or.kr/spo1/bbs/list.do?mId=110&CT_ID=RECRUIT"
f m_mjsports "https://www.mjsports.co.kr/"
f l_mjsports "https://www.mjsports.co.kr/bbs/board.php?bo_table=05_05"
f m_dgart "https://www.bsdgsportsart.or.kr/"
f l_dgart "https://www.bsdgsportsart.or.kr/subpage/index/32"
f m_donggusc "http://donggusc.co.kr/"
f m_ssnsc "https://www.ssnsc.or.kr/"
f l_ssnsc "https://www.ssnsc.or.kr/DyBoard/Board_list.asp?BGubun=0007"
f m_ydsports "https://www.ydsports.org/"
f m_sgsport "http://www.sgsport.co.kr/"
f m_gssports "http://www.gssports.or.kr/"
