#!/usr/bin/env bash
# (임시) 북구·강서구 새 소스 시험 수집
[ "$ATTEMPT" = "1" ] || exit 0
f() { python scripts/dev_fetch.py "$@" || true; }
f gs_view "https://eminwon.bsgangseo.go.kr/emwp/gov/mogaha/ntis/web/ofr/action/OfrAction.do?jndinm=OfrNotAncmtEJB&context=NTIS&method=selectOfrNotAncmt&methodnm=selectOfrNotAncmtRegst&not_ancmt_mgt_no=41289&homepage_pbs_yn=Y&subCheck=Y&ofr_pageSize=10&title=%EA%B3%A0%EC%8B%9C%EA%B3%B5%EA%B3%A0&initValue=Y&countYn=Y&list_gubun=A&Key=B_Subject"
python -m busan_jobs check-source bukgu_hire gangseo_gosi 2>&1 | tee probe_out/_check.txt
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source bukgu_hire gangseo_gosi 2>&1 | tail -40
