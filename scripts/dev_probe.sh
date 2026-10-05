#!/usr/bin/env bash
# (임시) 어린이집 게시판 조사 1차: 부산육아종합지원센터 어린이집 구인 전체 쪽, 직종별, 상세 GET
f() { python scripts/dev_fetch.py "$@" || true; }
U=https://busan.childcare.go.kr/ccef/job/JobOfferSlPL.jsp
for o in $(seq 0 10 280); do f "jo_$o" "$U?flag=SlPL&offset=$o"; done
f jo_etc "$U?flag=SlPL&offset=0&schEmpGbCode=36"
f jo_ther "$U?flag=SlPL&offset=0&schEmpGbCode=26"
f jo_view "https://busan.childcare.go.kr/ccef/job/JobOfferSl.jsp?flag=Sl&JOSEQ=2338462"
