#!/usr/bin/env bash
# (임시) 청소년상담복지센터 3차: 새 소스 목록 확인 + 해운대 AJAX 목록·기장·서구
f() { python scripts/dev_fetch.py "$@" || true; }
f udream_list_post "http://u-dream.or.kr/04/01.php?mode=list_ok&skind=&skey=&search=&page=1" "post:"
f udream_view "http://u-dream.or.kr/04/01.php?mode=view&uid=1"
f gijang1388 "https://www.gijangcmc.or.kr/1388/main/main.asp"
f seogu_https "https://www.flyseogu1388.or.kr/" ua
f seogu_ua "http://www.flyseogu1388.or.kr/" ua
f namgu_notice "https://www.namgu1388.kr/notice"
f meetyou_notice "http://meetyou.kr/community/notice/"
IDS="cando_notice cando_recruit gjyouth1388_notice namgu1388_notice bukgu1388_notice saha1388_notice meetyou_notice yeongdo1388_notice bsjin1388_notice udream_notice yeonje1388_notice"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
