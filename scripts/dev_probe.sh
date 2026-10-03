#!/usr/bin/env bash
# (임시) 장애인복지관 게시판 조사 2차
f() { python scripts/dev_fetch.py "$@" || true; }

f sigak_notice "https://www.newwhite.or.kr/boardList.do?BNUM=201512011&leftMenuNum=1&parentMenuNum=3&reqPage=1"
f seogu_notice "http://www.seogurc.or.kr/bbs/board.php?bo_table=sub04_01&me_code=4010"
f seogu_hire "http://www.seogurc.or.kr/bbs/board.php?bo_table=sub04_08&me_code=4090"
f yeongdo_notice "https://www.yeongdorc.or.kr/SW_bbs/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f yeongdo_hire "https://www.yeongdorc.or.kr/SW_bbs/list.php?zipEncode==i2BQ91vt1drjrMCH9MyMetpSfMvWLME"
f bsj_notice "https://bokji.chambokji.org/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f bsj_hire "https://bokji.chambokji.org/SW_bbs/notice/list.php?zipEncode==i2BQ91vt1drjrMCH9MyMetpSfMvWLME"
f namgu_notice "http://www.namgurc.or.kr/SW_bbs/list.php?zipEncode==etpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f nasaham_notice "https://www.nasaham.or.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f nasaham_hire "https://www.nasaham.or.kr/SW_bbs/notice/list.php?zipEncode=LTwy091vt1drjrMCH9MyMetpSfMvWLME"
f saha_notice "http://saharc.or.kr/board_notice01/list.php?tn=board_notice01&G_state=Y"
f saha_hire "http://saharc.or.kr/board_recruit01/list.php?tn=board_recruit01&G_state=Y"
f gj_notice "https://www.gjrc.or.kr/SW_bbs/list.php?zipEncode==etpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f gj_hire "https://www.gjrc.or.kr/SW_bbs/list.php?zipEncode==i2BQ91vt1drjrMCH9MyMetpSfMvWLME"
f gijang_notice "https://www.gijangbok.or.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f gijang_hire "https://www.gijangbok.or.kr/SW_bbs/notice/list.php?zipEncode==i2BQ91vt1drjrMCH9MyMetpSfMvWLME"
f sasang_main "http://www.sasangrc.or.kr/main/main.html"
f donggu_main "http://www.dgwc.or.kr/html/main/index.asp"
