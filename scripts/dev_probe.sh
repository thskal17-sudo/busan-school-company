#!/usr/bin/env bash
# (임시) 도서관 4차: 공공도서관 공지사항 목록
f() { python scripts/dev_fetch.py "$@" || true; }
pen() { f "pen_$1" "https://home.pen.go.kr/$1/na/ntt/selectNttList.do?mi=$2&bbsId=$3"; }
pen bansonglib 13041 3111
pen bellib 15686 4622
pen bujunlib 12783 3571
pen guducklib 12610 3515
pen guducklib_prog 17947 5418
pen haeundaelib 12022 3485
pen joonganglib 11009 3690
pen mjlib 12511 3530
pen sahalib 12293 3505
pen seodonglib 13655 3718
pen yeonsanlib 13431 3702
f pen_gupolib "https://home.pen.go.kr/gupolib/main.do"
f dadaelib "https://www.saha.go.kr/dadaelib/contents.do?mId=0509000000"
f hadanlib "https://www.saha.go.kr/hadanlib/bbs/list.do?ptIdx=761&mId=0601000000"
f gj_gyori "https://dlib.gijang.go.kr/gyori/contents.do?mId=0501000000"
f gj_gochon "https://library.gijang.go.kr/gochon/contents.do?mId=0401000000"
for c in gijang naeri ilgwang igchildlib jglib jgchildlib; do f "gj_$c" "https://library.gijang.go.kr/$c/main.do"; done
f dn_dongnae "https://dongnae.go.kr/lib/dongnae/index.php?g_page=community&m_page=community01"
f dn_allak "https://dongnae.go.kr/lib/allak/"
for c in gmlib gslib jslib; do f "gs_$c" "https://library.bsgangseo.go.kr/$c/index.php?g_page=community&m_page=community01"; done
f namgu_http "http://library.bsnamgu.go.kr/Main.do"
f geumjeong_lib "http://library.geumjeong.go.kr/"
f geumsaem "https://www.geumjeong.go.kr/gslib/index.geumj?menuCd=DOM_000001705001000000"
for c in bglib dclib mdlib hmlib; do f "bk_$c" "https://www.bsbukgu.go.kr/$c/index.bsbukgu"; done
f bk_bglib_notice "https://www.bsbukgu.go.kr/bglib/index.bsbukgu?menuCd=DOM_000001306001000000"
f dg_lib "http://www.bsdonggu.go.kr/board/list.donggu?boardId=BBS_0000083&menuCd=DOM_000000806001000000"
f dg_kidseng "http://www.bsdonggu.go.kr/board/list.donggu?boardId=BBS_0000261&menuCd=DOM_000002206001000000"
f seogu_am "https://www.bsseogu.go.kr/amlib/portal/board/post/list.do?bcIdx=500&mid=0801000000"
f bj_library "https://www.busanjin.go.kr/library/index.busanjin"
f bj_cylib "https://www.busanjin.go.kr/cylib/index.busanjin"
f hd_library "https://www.haeundae.go.kr/library/index.do"
f ss_notice "https://www.sasang.go.kr/library/index.sasang?menuCd=DOM_000000506001000000"
f ss_jrlib "https://www.sasang.go.kr/jrlib/index.sasang"
f yd_notice "https://www.yeongdo.go.kr/01354.web"
f yd_namhang "https://www.yeongdo.go.kr/01355.web"
f yj_notice "https://www.yeonje.go.kr/library/contents.do?mId=0701000000"
f yj_manhwa "https://www.yeonje.go.kr/manhwalib/main.do"
f portal_news "https://library.busan.go.kr/portal/board/index.do?menu_idx=27&manage_idx=24"
