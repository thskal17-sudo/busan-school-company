#!/usr/bin/env bash
# (임시) 청소년상담복지센터 4차: 사하 목록, 해운대·수영 상세 주소, 기장, 전체 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
f saha_list "https://saha1388.kr/bbs/board.php?bo_table=center_notice"
f saha_list_ua "https://saha1388.kr/bbs/board.php?bo_table=center_notice" ua
f udream_view "http://u-dream.or.kr/04/01.php?mode=view&uid=270"
f meetyou_read "http://meetyou.kr/community/notice/?mode=read&dir=read&number=636"
f gijang1388_http "http://www.gijangcmc.or.kr/1388/main/main.asp"
f gijang1388_info "https://www.gijangcmc.or.kr/1388/01_info/01_info.asp?id=Notice"
IDS="cando_notice cando_recruit gjyouth1388_notice namgu1388_notice bukgu1388_notice meetyou_notice yeongdo1388_notice bsjin1388_notice udream_notice yeonje1388_notice"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패|^  \["
