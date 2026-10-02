#!/usr/bin/env bash
# (임시) 여성인력개발센터·새일센터 게시판 조사 2차
f() { python scripts/dev_fetch.py "$@" || true; }

f gs_notice "https://www.bsgangseo.go.kr/welfare/contents.do?mid=0106000000"
f gs_women "https://www.bsgangseo.go.kr/welfare/contents.do?mid=0407000000"
f wcc_home "https://www.busan.go.kr/wcc/index"
f wcc_notice "https://www.busan.go.kr/wcc/wcnotice"
f woman_notice "https://www.busan.go.kr/woman/whnotice"
f woman_home "https://www.busan.go.kr/woman/index"
f bs_free "https://www.bswoman.or.kr/sub4/sub3.aspx"
