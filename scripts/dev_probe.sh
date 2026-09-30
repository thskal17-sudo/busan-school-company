#!/usr/bin/env bash
# (임시) 복지관 1차: 사회복지관협회·사회복지협의회·노인복지시설협회·사회복지사협회 구인 게시판
f() { python scripts/dev_fetch.py "$@" || true; }
f baswc_hire "https://www.baswc.org/SW_bbs/notice/list.php?zipEncode==ixzRj3B391vt1drjrMCH9MyMetpSfMvWLME"
f bswin_job "https://bswin.net/information_job"
f bfsw_main "https://www.bfsw.kr/"
f basw_main "https://basw.or.kr/"
f welfare_busan "https://welfare.net/busan/"
f bokji_job "https://www.bokji.net/job/off/01.bokji"
