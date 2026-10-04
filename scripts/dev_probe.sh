#!/usr/bin/env bash
# (임시) 문화센터 게시판 조사 2차: 미디어센터·영화의전당·국악원·미술관·렛츠런·시민회관
f() { python scripts/dev_fetch.py "$@" || true; }
r() { curl -s -m 20 -A "Mozilla/5.0" -o "probe_out/robots_$1.txt" -w "[robots_$1] %{http_code} %{size_download}B\n" "$2/robots.txt" || true; }

r kcmf https://kcmf.or.kr
r dure https://www.dureraum.org
r wbusan https://wbusan.dureraum.org
r gugak https://busan.gugak.go.kr
r art https://art.busan.go.kr
r kra https://ccc.kra.co.kr
r bscc https://www.bscc.or.kr

f kcmf_bs "https://kcmf.or.kr/KCMF/contents/KCMF050107.do"
f dure_notice "https://www.dureraum.org/bcc/board/list.do?rbsIdx=46"
f wbusan_main "https://wbusan.dureraum.org/"
f gugak_rec "https://busan.gugak.go.kr/BG/contents/BG0402020000.do"
f gugak_notice "https://busan.gugak.go.kr/BG/contents/BG0402010000.do"
f art_anucmt "https://art.busan.go.kr/anucmt/list.nm"
f art_main "https://art.busan.go.kr/index.nm"
f kra_agree "https://ccc.kra.co.kr/ccc/instruction/application/instruction_application_agreement.do"
f kra_list "https://ccc.kra.co.kr/ccc/instruction/application/instruction_application_list.do"
f citizen_news "https://www.bscc.or.kr/citizen/05_community/?mcode=1005010000"
