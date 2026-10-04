#!/usr/bin/env bash
# (임시) 아동보호전문기관 게시판 조사 2차: 공지 게시판, 남부 새 주소, '강사' 검색
f() { python scripts/dev_fetch.py "$@" || true; }
K=%EA%B0%95%EC%82%AC  # 강사
f sb_notice "https://busansb.gcps.or.kr/gnbusansb/board/cd103101100/default"
f sb_news "https://busansb.gcps.or.kr/gnbusansb/board/cd103102100/default"
f robots_db "http://dbchild.saem.or.kr/robots.txt"
f db_notice "http://dbchild.saem.or.kr/community/notice-3/"
f robots_jb "http://jbusan1391.or.kr/robots.txt"
f jb_notice "http://jbusan1391.or.kr/bbs/board.php?bo_table=notice"
f jb_notice_s "http://jbusan1391.or.kr/bbs/board.php?bo_table=notice&sfl=wr_subject&stx=$K"
f robots_nc "http://nchild.wavework.kr/robots.txt"
f nc_home "http://nchild.wavework.kr/"
f nc_board "http://nchild.wavework.kr/bbs/board.php?bo_table=board"
f nc_board_s "http://nchild.wavework.kr/bbs/board.php?bo_table=board&sfl=wr_subject&stx=$K"
f nc_home_https "https://nchild.wavework.kr/"
