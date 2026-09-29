#!/usr/bin/env bash
# (임시) 북구·강서구·수영구 채용 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }
EM='emwp/gov/mogaha/ntis/web/ofr/action/OfrAction.do?jndinm=OfrNotAncmtEJB&context=NTIS&method=selectListOfrNotAncmt&methodnm=selectListOfrNotAncmtHomepage&homepage_pbs_yn=Y&subCheck=Y&ofr_pageSize=10&title=%EA%B3%A0%EC%8B%9C%EA%B3%B5%EA%B3%A0&initValue=Y&countYn=Y&epcCheck=Y&nodate_recent_mm=12&pageIndex=1'
# 수영구 (해외 접속 차단 확인: 시도마다 러너가 다를 수 있음)
f sy_www "https://www.suyeong.go.kr/index.suyeong"
f sy_www_ua "https://www.suyeong.go.kr/index.suyeong" ua
f sy_hire "https://www.suyeong.go.kr/index.suyeong?menuCd=DOM_000000103001010001"
f sy_em "https://eminwon.suyeong.go.kr/$EM&not_ancmt_se_code=05"
f sy_m "https://m.suyeong.go.kr/"
f sy_bare "https://suyeong.go.kr/"
[ "$ATTEMPT" = "1" ] || exit 0
# 북구
f bukgu_jobs "https://www.bsbukgu.go.kr/board/list.bsbukgu?boardId=BBS_0000017&menuCd=DOM_000000103007012005&contentsSid=200"
f bukgu_gosi "https://www.bsbukgu.go.kr/index.bsbukgu?menuCd=DOM_000000105001005000"
f em_bukgu_0104 "https://eminwon.bsbukgu.go.kr/$EM&not_ancmt_se_code=01,04"
# 강서구
f gs_notice "https://www.bsgangseo.go.kr/portal/board/post/list.do?bcIdx=500&mid=0501010000"
f gs_gosi "https://www.bsgangseo.go.kr/portal/contents.do?mid=0501020000"
f gs_jobs "https://www.bsgangseo.go.kr/portal/contents.do?mid=0305000000"
f gs_public "https://www.bsgangseo.go.kr/portal/contents.do?mid=0305030000"
f em_gangseo_0104 "https://eminwon.bsgangseo.go.kr/$EM&not_ancmt_se_code=01,04"
f em_gangseo_all "https://eminwon.bsgangseo.go.kr/$EM"
