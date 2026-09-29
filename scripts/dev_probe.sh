#!/usr/bin/env bash
# (임시) 부산 게시판 조사 5차: 새올 머리글 가설 재확인, 동구청 0건 화면, 중복 판정 넣은 전체 수집
f() { python scripts/dev_fetch.py "$@" || true; }
S='emwp/gov/mogaha/ntis/web/ofr/action/OfrAction.do?jndinm=OfrNotAncmtEJB&context=NTIS&method=selectListOfrNotAncmt&methodnm=selectListOfrNotAncmtHomepage&homepage_pbs_yn=Y&subCheck=Y&ofr_pageSize=10&not_ancmt_se_code=05&title=%EC%B1%84%EC%9A%A9%EA%B3%B5%EA%B3%A0&initValue=Y&countYn=Y&epcCheck=Y&nodate_recent_mm=12&pageIndex=1'
for h in bsnamgu sasang; do
  f "default_$h" "https://eminwon.$h.go.kr/$S"
  f "noal_$h" "https://eminwon.$h.go.kr/$S" noal
done
f dg_em "https://eminwon.bsdonggu.go.kr/$S"
f dg_hire "https://www.bsdonggu.go.kr/board/list.donggu?boardId=BBS_0000307&menuCd=DOM_000000104004011002"
f dg_lll "https://www.bsdonggu.go.kr/lll/board/list.donggu?boardId=BBS_0000104&menuCd=DOM_000000605000000000"
f dg_home "https://www.bsdonggu.go.kr/index.donggu"
python -m busan_jobs check-source namgu_eminwon sasang_eminwon donggu_eminwon donggu_hire donggu_lifelong 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류" || true
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out > probe_out/_run.txt 2>&1 || true
grep -E "^\[|^신규" probe_out/_run.txt || tail -30 probe_out/_run.txt
