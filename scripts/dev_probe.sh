#!/usr/bin/env bash
# (임시) 문화센터 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }

f bsarte_home "https://bsarte.bscf.or.kr/"
f bsarte_notice "https://bsarte.bscf.or.kr/board/list/1"
f bscf_news "https://www.bscf.or.kr/portal/bbs/list.do?ptIdx=113&mId=0401000000"
f bscc_notice "https://www.bscc.or.kr/05_community/?mcode=0405010000"
f bacs_home "https://home.pen.go.kr/bacs/main.do"
f bsec_home "https://home.pen.go.kr/bsec/main.do"
f bjlife "http://busanjinlifeculture.quv.kr/5"
f hd_culture "https://www.haeundae.go.kr/culture/index.do"
f bukgu_culture "https://www.bsbukgu.go.kr/index.bsbukgu?menuCd=DOM_000000402003001002"
f yeongdo_art "https://www.yeongdo.go.kr/art.web"
