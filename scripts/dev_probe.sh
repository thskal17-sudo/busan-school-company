#!/usr/bin/env bash
# (임시) 부산 게시판 조사 4차: 전체 시험 수집 + 새올 400 원인 확인 + 상세 페이지 샘플
f() { python scripts/dev_fetch.py "$@" || true; }
S='emwp/gov/mogaha/ntis/web/ofr/action/OfrAction.do?jndinm=OfrNotAncmtEJB&context=NTIS&method=selectListOfrNotAncmt&methodnm=selectListOfrNotAncmtHomepage&homepage_pbs_yn=Y&subCheck=Y&ofr_pageSize=10&not_ancmt_se_code=05&title=%EC%B1%84%EC%9A%A9%EA%B3%B5%EA%B3%A0&initValue=Y&countYn=Y&epcCheck=Y&nodate_recent_mm=12&pageIndex=1'
for h in bsnamgu sasang gijang; do
  f "ua_$h" "https://eminwon.$h.go.kr/$S" ua
  f "noal_$h" "https://eminwon.$h.go.kr/$S" noal
  f "both_$h" "https://eminwon.$h.go.kr/$S" ua noal
done
curl -s -m 20 -o probe_out/curl_bsnamgu.html -w "curl bsnamgu %{http_code} %{size_download}\n" "https://eminwon.bsnamgu.go.kr/$S" || true
f det_pen "https://www.pen.go.kr/main/na/ntt/selectNttInfo.do?mi=30367&bbsId=2364&nttSn=1180893"
f det_af "https://home.pen.go.kr/afterschool/na/ntt/selectNttInfo.do?mi=14360&bbsId=4177&nttSn=1014630"
f det_bnfmc "https://www.bnfmc.or.kr/portal/gosiInfo/view.do?mId=0404000000&idx=297"
f det_busanjob "https://www.busanjob.net/view.do?no=1309&pgMode=show&id=288592"
f det_bscf "https://www.bscf.or.kr/view.do?no=1025&pgMode=show&pbancSn=2428"
f pen_hire_p2 "https://www.pen.go.kr/main/na/ntt/selectNttList.do?mi=30367&bbsId=2364&currPage=2"
python -m busan_jobs check-source gojobs_list alio_recruit pen_school_hire pen_gosi pen_kinder_hire afterschool_private afterschool_company seobu_edu_hire nambu_edu_hire bukbu_edu_hire dongnae_edu_hire haeundae_edu_hire city_jobs city_jobs_other city_stadium_notice seogu_eminwon donggu_eminwon yeongdo_eminwon busanjin_eminwon dongnae_eminwon haeundae_eminwon saha_eminwon geumjeong_eminwon yeonje_eminwon donggu_hire junggu_hire gijang_jobs namgu_jobs bnfmc_hire gijangcmc_hire dongnae_sports_hire haeundae_lifelong saha_lifelong geumjeong_lifelong yeonje_lifelong gijang_lifelong namgu_lifelong bukgu_lifelong donggu_lifelong seogu_lifelong junggu_lifelong sasang_lifelong gangseo_lifelong busan_library simin_library busanyouth_notice geumnyeonsan_youth womenhall_notice bgli_hire bgli_other bepa_hire bepa_training bscf_hire busanjob_public 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류|설정필요" || true
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out 2>&1 | tail -150 > probe_out/_run.txt || true
tail -80 probe_out/_run.txt
