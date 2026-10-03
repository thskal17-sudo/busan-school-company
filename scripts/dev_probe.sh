#!/usr/bin/env bash
# (임시) 노인복지관 게시판 조사 2차
f() { python scripts/dev_fetch.py "$@" || true; }

f jangsan_main "http://www.haeundaejangsan.or.kr/html/comm/main.asp"
f dnswc_program "https://www.dnswc.or.kr/SW_bbs/notice/list.php?zipEncode==mtpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
python -m busan_jobs check-source senior_dongnae_notice > probe_out/check.txt 2>&1 || true
