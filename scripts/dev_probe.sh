#!/usr/bin/env bash
# (임시) 주민자치센터(동 행정복지센터) 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }

f bsj_dong_all "https://www.busanjin.go.kr/board/list.busanjin?boardId=DONGNOTICE"
f bsj_dong_g1 "https://www.busanjin.go.kr/gaegeum1/board/list.busanjin?boardId=DONGNOTICE&menuCd=DOM_000005804001000000&categoryCode1=gaegeum1"
f bsj_dong_nocat "https://www.busanjin.go.kr/gaegeum1/board/list.busanjin?boardId=DONGNOTICE&menuCd=DOM_000005804001000000"
f jumin04 "https://www.busan.go.kr/jumin04"
f h_junggu "https://www.bsjunggu.go.kr/index.junggu"
f h_seogu "https://www.bsseogu.go.kr/index.bsseogu"
f h_donggu "https://www.bsdonggu.go.kr/index.donggu"
f h_yeongdo "https://www.yeongdo.go.kr/"
f h_dongnae "https://www.dongnae.go.kr/index.dongnae"
f h_namgu "https://www.bsnamgu.go.kr/index.namgu"
f h_bukgu "https://www.bsbukgu.go.kr/index.bsbukgu"
f h_saha "https://www.saha.go.kr/portal/main.do"
f h_gangseo "https://www.bsgangseo.go.kr/portal/main.do"
f h_yeonje "https://www.yeonje.go.kr/main.do"
f h_sasang "https://www.sasang.go.kr/index.sasang"
f h_gijang "https://www.gijang.go.kr/index.gijang"
f h_geumjeong "https://www.geumjeong.go.kr/index.geumj"
f h_haeundae "https://www.haeundae.go.kr/index.do"
