#!/usr/bin/env bash
# (임시) 문화센터 게시판 조사 2-2차: 상세 주소 확인 + 지난 '강사' 글 검색
f() { python scripts/dev_fetch.py "$@" || true; }
K=%EA%B0%95%EC%82%AC  # 강사

f kcmf_view "https://kcmf.or.kr/KCMF/contents/KCMF050107.do?schM=view&id=CJSONOIHhcctr_ul9r1-R_a9R4N3Cud2xksvkc6Eu58"
f kcmf_s "https://kcmf.or.kr/KCMF/contents/KCMF050107.do?schFld=1&schStr=$K"
f art_view "https://art.busan.go.kr/anucmt/view.nm?tta_seq=101"
f art_s "https://art.busan.go.kr/anucmt/list.nm?searchCnd=0&searchWrd=$K"
f gugak_view "https://busan.gugak.go.kr/BG/contents/BG0402010000.do?schM=view&id=20260804110102928264"
f gugak_notice_s "https://busan.gugak.go.kr/BG/contents/BG0402010000.do?schFld=1&schStr=$K"
f gugak_rec_s "https://busan.gugak.go.kr/BG/contents/BG0402020000.do?schFld=1&schStr=$K"
f dure_s "https://www.dureraum.org/bcc/board/list.do?rbsIdx=46&keyField=search1&key=$K"
f bscc_main "https://www.bscc.or.kr/05_community/?mcode=0405010000"
f citizen_s "https://www.bscc.or.kr/citizen/05_community/?mcode=1005010000&kd=title&kw=$K"
f bscc_s "https://www.bscc.or.kr/05_community/?mcode=0405010000&kd=title&kw=$K"
