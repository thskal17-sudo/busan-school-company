#!/usr/bin/env bash
# (임시) 장애인복지관 게시판 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
f sigak_view "https://www.newwhite.or.kr/boardView.do?BNUM=201512011&SEQ=20260915000000&leftMenuNum=1&parentMenuNum=3&reqPage=1&imgNum=1"
f sasang_notice "http://www.sasangrc.or.kr/board_notice01/list.php?tn=board_notice01&G_state=Y"
python -m busan_jobs check-source dis_sigak_notice dis_seogu_hire dis_yeongdo_hire dis_busanjin_hire dis_namgu_notice \
  dis_nasaham_hire dis_saha_hire dis_geumjeong_hire dis_gijang_hire dis_sasang_notice > probe_out/check.txt 2>&1 || true
