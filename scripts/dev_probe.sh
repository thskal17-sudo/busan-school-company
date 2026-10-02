#!/usr/bin/env bash
# (임시) 체육센터 3차: 새로 찾은 체육회·체육센터, 남은 채용 게시판
f() { python scripts/dev_fetch.py "$@" || true; }
curl -s -m 20 -o probe_out/sylink05.js "https://www.sysports.or.kr/js/sylink05.js" || true
f c_syg_h "https://www.sygsports.co.kr/bbs/board.php?bo_table=05_08"
f c_gj_h "https://www.gjsports.go.kr/bbs/board.php?bo_table=05_05"
f m_bbsc "https://bbsc.kr/"
f m_yd7330 "https://yd7330.com/"
f m_hud7330 "http://www.hud7330.com/"
f m_yjsports "https://www.yj-sports.or.kr/"
f m_bnsc "http://www.bnsc.or.kr/"
f m_bnsc_s "https://www.bnsc.or.kr/"
f m_bukgu "https://bukgusports.com/"
f m_saba "http://www.saba.or.kr/"
f m_gscsports "http://www.gscsports.or.kr/" ua
f m_sasangsports "http://sasangsports.com/" ua
