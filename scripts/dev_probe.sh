#!/usr/bin/env bash
# (임시) 문화센터 게시판 조사 2차
f() { python scripts/dev_fetch.py "$@" || true; }

f bsarte_notice "https://bsarte.bscf.or.kr/board/lists/1"
f bsarte_local "https://bsarte.bscf.or.kr/board/lists/15"
f bacs_notice "https://home.pen.go.kr/bacs/na/ntt/selectNttList.do?mi=10447&bbsId=3402"
f bacs_5515 "https://home.pen.go.kr/bacs/na/ntt/selectNttList.do?mi=18261&bbsId=5515"
f bacs_3396 "https://home.pen.go.kr/bacs/na/ntt/selectNttList.do?mi=10421&bbsId=3396"
f bacs_3392 "https://home.pen.go.kr/bacs/na/ntt/selectNttList.do?mi=10416&bbsId=3392"
f bsec_notice "https://home.pen.go.kr/bsec/na/ntt/selectNttList.do?mi=10652&bbsId=3244"
f bukgu_tour "https://www.bsbukgu.go.kr/tour/index.bsbukgu?menuCd=DOM_000000407001000000"
f bscf_home "https://www.bscf.or.kr/"
