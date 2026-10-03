#!/usr/bin/env bash
# (임시) 주민자치센터(동 행정복지센터) 게시판 조사 4차
f() { python scripts/dev_fetch.py "$@" || true; }

f bk_all "https://www.bsbukgu.go.kr/board/list.bsbukgu?boardId=BBS_0000125"
f ss_all "https://www.sasang.go.kr/board/list.sasang?boardId=BBS_0000173"
f gs_all "https://www.bsgangseo.go.kr/portal/board/post/list.do?bcIdx=543&mid=0604010200"
f dg_d2 "https://www.bsdonggu.go.kr/jumin/board/list.donggu?boardId=BBS_0000173&menuCd=DOM_000001502003000000&welfareCo=1014000000000"
f gj_news "https://www.geumjeong.go.kr/dong/index.geumj?menuCd=DOM_000001001004001000"
f dn_d2 "https://www.dongnae.go.kr/dong/index.dongnae?menuCd=DOM_000001117000000000"
f sh_dadae2 "https://www.saha.go.kr/dadae2/bbs/list.do?mId=0501000000&ptIdx=542"
f sh_goe1 "https://www.saha.go.kr/goejeong1/main.do"
f jg_d "https://www.bsjunggu.go.kr/dong/index.junggu?menuCd=DOM_000001101001001000&link=success&cpath=%2Fdong"
