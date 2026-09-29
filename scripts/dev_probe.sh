#!/usr/bin/env bash
# (임시) 청소년수련관 게시판 조사 3차: 나머지 수련관 첫 화면 + 찾은 게시판
f() { python scripts/dev_fetch.py "$@" || true; }
f kumgok "http://kum-gok.or.kr/"
f yzzang_main "http://www.yzzang.com/main.php"
f gudeok "http://www.gudeok.go.kr/"
f hamji "http://www.hamji.or.kr/"
f ymcahy_s "https://www.ymcahy.or.kr/"
f gc_notice "https://www.youthcool.or.kr/SW_bbs/notice/list.php?zipEncode==atpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f dn_emp "https://www.onnainna.kr/community/employment_board"
f dn_notice "https://www.onnainna.kr/community/notice_board"
f yj_notice "https://www.power0924.org/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
