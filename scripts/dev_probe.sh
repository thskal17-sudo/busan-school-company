#!/usr/bin/env bash
# (임시) 문화센터 2차: 공지 게시판 목록, 나머지 문화원 첫 화면, 메뉴 스크립트
f() { python scripts/dev_fetch.py "$@" || true; }
f l_busanjin "http://busanjin.kccf.or.kr/board/notice.php"
f l_donggu "http://bdgcc.or.kr/sb51.php"
f l_haeundae "http://www.hudcc.or.kr/board/bbs.asp?code=news"
f l_namgu "http://www.bsnamgucc.or.kr/app/notice"
f l_seogu "https://www.seogucc.or.kr/bbs/board.php?bo_table=notice"
f l_yeonje_n "https://www.bsyjculture.or.kr/?pagecode=P000000043"
f l_yeonje_s "https://www.bsyjculture.or.kr/?pagecode=P000000012"
f l_dongnae_hall "https://www.dongnae.go.kr/culture/index.dongnae?menuCd=DOM_000000606001000000"
f l_dongnae_cc "http://dongnae.kccf.or.kr/home/main/madang.php?menuinfo_code=notice"
f l_sasang_kccf "http://sasang.kccf.or.kr/home/main/madang.php?menuinfo_code=notice"
for s in "ydculture http://www.ydculture.com/" "sahacc http://sahacc.kr/" "suyeongcc http://www.suyeongcc.or.kr/" \
         "sasangculture http://sasangculture.or.kr/" "gijangcc http://gijangcc.or.kr/" "busankccf http://busan.kccf.or.kr/" \
         "kumjungkccf http://kumjung.kccf.or.kr/"; do set -- $s; f "m_$1" "$2"; done
for s in "junggu https://www.bsjunggucc.com/js/menu.js" "kumjung http://kumjung.or.kr/js/menu.js" \
         "artgj https://art.geumjeong.go.kr/new_js/menu.js" "gjfac https://www.gjfac.org/js/menu.js"; do
  set -- $s; curl -s -m 20 -o "probe_out/js_$1.js" "$2" || true
done
