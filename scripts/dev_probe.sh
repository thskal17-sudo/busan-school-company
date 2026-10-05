#!/usr/bin/env bash
# (임시) 장난감도서관 게시판 조사 1차
f() { python scripts/dev_fetch.py "$@" || true; }
f bokjibank "http://www.bokjibank.or.kr/bokji/view.php?zipEncode=%3DetnY0tB152x3vwA2zspSfMvWLME"
f busan_toy "https://www.busan.go.kr/nhot/1150870"
f bds_toy "https://www.bdscc.or.kr/toy/main.asp"
f bgs_toy "https://www.bgscc.or.kr/m6/sub2_1.asp"
f bbg_toy "https://www.bbgscc.or.kr/m2/sub3.asp"
f gj_toy "https://www.gijangchild.or.kr/m2/sub3_1.asp"
f bsscc_toy "https://www.bsscc.or.kr/parent/toy_list.asp"
