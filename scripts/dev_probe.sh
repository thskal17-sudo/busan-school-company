#!/usr/bin/env bash
# (임시) 부산 여성인력개발센터 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }
f dir_center "https://www.busan.go.kr/depart/woman030103"
f dir_saeil "https://www.busan.go.kr/depart/woman0301"
f bsj_notice "https://www.bswoman.or.kr/sub4/sub1.aspx"
f dn_home "https://www.womancenter.or.kr/"
f dn_sub3_1 "https://www.womancenter.or.kr/sub3/sub1.aspx"
f dn_sub3_4 "https://www.womancenter.or.kr/sub3/sub4.aspx"
f dn_sub3_5 "https://www.womancenter.or.kr/sub3/sub5.aspx"
f hw_notice "https://hwcenter.or.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f dg_home "http://www.ewoman.or.kr/"
f dg_home_s "https://www.ewoman.or.kr/"
