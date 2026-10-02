#!/usr/bin/env bash
# (임시) 문화센터 3차: 나머지 공지 게시판
f() { python scripts/dev_fetch.py "$@" || true; }
f l_junggu "https://www.bsjunggucc.com/sub/template.php?midx=50"
f l_kumjung "http://www.kumjung.or.kr/sub/template.php?midx=50"
f l_gjfac_n "https://www.gjfac.org/gjfac/template.php?midx=347"
f l_gjfac_h "https://www.gjfac.org/gjfac/template.php?midx=349"
f l_artgj "https://art.geumjeong.go.kr/sub/template.asp?midx=63"
f l_sahacc "http://sahacc.kr/notice/"
f m_gijangcc "http://gijangcc.or.kr/main/index.php"
f l_bscc "https://www.bscc.or.kr/05_community/?mcode=0405010000"
f m_ydculture_ua "https://www.ydculture.com/" ua
f m_suyeongcc_ua "http://www.suyeongcc.or.kr/" ua
f m_nakdong_ua "http://nakdong.or.kr/" ua
f m_gangseo_main "http://www.bsgangseo.com/main/main.php"
