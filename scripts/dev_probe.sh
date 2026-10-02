#!/usr/bin/env bash
# (임시) 체육센터 2차: 공지·채용 게시판 목록, 못 받은 첫 화면 다시
f() { python scripts/dev_fetch.py "$@" || true; }
f s_city_notice "http://www.sports.busan.kr/contents/05_notice/board.html?board_id=board_notice"
for s in "bjs http://www.busanjingu-sports.or.kr notice recruit" "bng http://www.bngsports.or.kr notice recruit" \
         "gs https://www.gs7330.com notice employment" "jg http://www.bsjgsc7330.co.kr notice job" \
         "saha http://sahasports.or.kr notice recruit" "sy http://www.sportssy.or.kr notice recruit"; do
  set -- $s; f "a_$1_n" "$2/bbs/board.php?bo_table=$3"; f "a_$1_h" "$2/bbs/board.php?bo_table=$4"
done
f a_seo_n "http://bsseogusports.or.kr/bbs/board.php?bo_table=sub4_1"
f c_jsports_n "https://www.jsports.or.kr/bbs/board.php?bo_table=05_01"
f c_jsports_h "https://www.jsports.or.kr/bbs/board.php?bo_table=05_02"
f c_sahak_n "https://www.sahaksports.or.kr/saha/207"
f c_sahak_h "https://www.sahaksports.or.kr/saha/211"
f c_yeonje_n "https://sports.yeonje.go.kr/subpage/index/87"
f c_yeonje_h "https://sports.yeonje.go.kr/subpage/index/89"
f c_hdswim_n "http://www.haeundaeswim.com/bbs/board.php?bo_table=notice"
f m_sygsports "https://www.sygsports.co.kr/"
f m_sysports "https://www.sysports.or.kr/emSolution"
f m_portal_assoc "https://www.busan.go.kr/sports/main/28"
f m_bnsc "http://www.bnsc.or.kr/"
f m_bukgu "http://bukgusports.com/"
f m_gjsports "https://www.gjsports.go.kr/"
f m_saba "https://www.saba.or.kr/"
f m_gscsports "https://www.gscsports.or.kr/" ua
f m_sasangsports "https://sasangsports.com/" ua
