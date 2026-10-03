#!/usr/bin/env bash
# (임시) 주민자치센터(동 행정복지센터) 게시판 조사 2차
f() { python scripts/dev_fetch.py "$@" || true; }

f dn_all "https://www.dongnae.go.kr/board/list.dongnae?boardId=DONGNOTICE"
f bk_all "https://www.bsbukgu.go.kr/board/list.bsbukgu?boardId=DONGNOTICE"
f ss_all "https://www.sasang.go.kr/board/list.sasang?boardId=DONGNOTICE"
f gj_all "https://www.geumjeong.go.kr/board/list.geumj?boardId=DONGNOTICE"
f jg_all "https://www.bsjunggu.go.kr/board/list.junggu?boardId=DONGNOTICE"
f dg_all "https://www.bsdonggu.go.kr/board/list.donggu?boardId=DONGNOTICE"
f gjang_all "https://www.gijang.go.kr/board/list.gijang?boardId=DONGNOTICE"
f nm_all "https://www.bsnamgu.go.kr/board/list.namgu?boardId=DONGNOTICE"
f sg_all "https://www.bsseogu.go.kr/board/list.bsseogu?boardId=DONGNOTICE"
f d_junggu "https://www.bsjunggu.go.kr/dong/index.junggu?menuCd=DOM_000001101000000000"
f d_seogu "https://www.bsseogu.go.kr/index.bsseogu?menuCd=DOM_000000104007001000"
f d_donggu "https://www.bsdonggu.go.kr/jumin/index.donggu?welfareCo=1013000000000"
f d_yeongdo "https://www.yeongdo.go.kr/00573.web"
f d_namgu "https://www.bsnamgu.go.kr/daeyeon1/index.namgu"
f d_yeonje "https://www.yeonje.go.kr/dong/main.do"
f d_sasang "https://www.sasang.go.kr/index.sasang?menuCd=DOM_000001301001001000"
f d_geumjeong "https://www.geumjeong.go.kr/dong/index.geumj?menuCd=DOM_000001001000000000"
f d_gangseo "https://www.bsgangseo.go.kr/portal/contents.do?mid=0604010000"
