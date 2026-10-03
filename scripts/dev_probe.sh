#!/usr/bin/env bash
# (임시) 주민자치센터(동 행정복지센터) 게시판 조사 3차
f() { python scripts/dev_fetch.py "$@" || true; }

f dg_comb "https://www.bsdonggu.go.kr/jumin/board/list.donggu?boardId=BBS_0000173&menuCd=DOM_000001502003000000"
f nm_comb "https://www.bsnamgu.go.kr/board/list.namgu?boardId=BBS_0000123"
f nm_d1 "https://www.bsnamgu.go.kr/board/list.namgu?boardId=BBS_0000123&menuCd=DOM_000001104001000000"
f yj_jumin "https://www.yeonje.go.kr/dong/bbs/list.do?ptIdx=130&mId=0405000000"
f ss_d1 "https://www.sasang.go.kr/index.sasang?menuCd=DOM_000001301002001000"
f gs_d1 "https://www.bsgangseo.go.kr/portal/contents.do?mid=0604010200"
f gs_d1_jumin "https://www.bsgangseo.go.kr/portal/contents.do?mid=0604010600"
