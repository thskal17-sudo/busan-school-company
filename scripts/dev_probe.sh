#!/usr/bin/env bash
# (임시) 여성인력개발센터·새일센터 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }

f hw_home "https://www.hwcenter.or.kr/"
f bs_home "https://www.bswoman.or.kr/"
f sh_home "https://www.sahawcenter.or.kr/"
f dg_job "http://www.ewoman.or.kr/p/?j=75"
f dg_home "http://www.ewoman.or.kr/"
f dn_job "https://www.womancenter.or.kr/sub2/sub2.aspx"
f wcc_home "https://www.busan.go.kr/wcc/index"
f woman_home "https://www.busan.go.kr/woman/index"
f gijang_saeil "https://www.gijang.go.kr/index.gijang?menuCd=DOM_000000104009006000"
f gangseo_saeil "https://www.bsgangseo.go.kr/welfare/contents.do?mid=0408010000"
f gangseo_saeil2 "https://www.bsgangseo.go.kr/welfare/contents.do?mid=0408020000"
f city_abnotice "https://www.busan.go.kr/depart/abnotice"
