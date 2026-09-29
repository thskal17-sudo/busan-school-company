#!/usr/bin/env bash
# (임시) 부산 게시판 조사 2차: 메뉴에서 찾은 채용 게시판 + 구·군 새올 채용공고 목록
f() { python scripts/dev_fetch.py "$@" || true; }
EM='emwp/gov/mogaha/ntis/web/ofr/action/OfrAction.do?jndinm=OfrNotAncmtEJB&context=NTIS&method=selectListOfrNotAncmt&methodnm=selectListOfrNotAncmtHomepage&homepage_pbs_yn=Y&subCheck=Y&ofr_pageSize=10&not_ancmt_se_code=05&title=%EC%B1%84%EC%9A%A9%EA%B3%B5%EA%B3%A0&initValue=Y&countYn=Y&epcCheck=Y&nodate_recent_mm=12&pageIndex=1'
for h in bsjunggu bsseogu bsdonggu yeongdo busanjin dongnae bsnamgu bsbukgu haeundae saha geumjeong bsgangseo yeonje suyeong sasang gijang; do
  f "em_$h" "https://eminwon.$h.go.kr/$EM"
done
f city_incruit https://www.busan.go.kr/nbincruit
f city_jobexam https://www.busan.go.kr/depart/jobexam01
f city_jobgonji https://www.busan.go.kr/depart/jobgonji01
f city_gosi https://www.busan.go.kr/nbgosi
f donggu_hire "https://www.bsdonggu.go.kr/index.donggu?menuCd=DOM_000000104004011002"
f saha_hire "https://www.saha.go.kr/portal/contents.do?mId=0301150000"
f sasang_hire "https://www.sasang.go.kr/index.sasang?menuCd=DOM_000000109003007000"
f yeonje_hire "https://www.yeonje.go.kr/portal/saeol/gosi/list.do?seCode=05&mId=0206070000"
f junggu_job "https://www.bsjunggu.go.kr/job/index.junggu"
f yeongdo_gosi "https://www.yeongdo.go.kr/00000/00007/00013.web"
f pen_main "https://www.pen.go.kr/main/main.do"
f haeundae_main "https://www.haeundae.go.kr/index.do"
f busanjin_main "https://www.busanjin.go.kr/index.busanjin"
f bukgu_main "https://www.bsbukgu.go.kr/index.bsbukgu?contentsSid=1"
f dongnae_main "https://www.dongnae.go.kr/index.dongnae?contentsSid=2073"
f namgu_main "https://www.bsnamgu.go.kr/index.namgu"
f gijang_main "https://www.gijang.go.kr/index.gijang?contentsSid=1219"
f bepa_hire "https://www.bepa.kr/kor/view.do?no=1509"
f bepa_ind "https://www.bepa.kr/kor/view.do?no=1504"
f busanjob https://www.busanjob.net/
f bisco_http http://www.bisco.or.kr/
f geumjeong_http http://www.geumjeong.go.kr/
f suyeong_http http://www.suyeong.go.kr/
