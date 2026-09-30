#!/usr/bin/env bash
# (임시) 도서관 1차: 도서관포털 현황·소식, 교육청 도서관 첫 화면
f() { python scripts/dev_fetch.py "$@" || true; }
f portal_list "https://library.busan.go.kr/portal/module/libraryInfo/index.do?menu_idx=73"
f portal_list2 "https://library.busan.go.kr/portal/module/libraryInfo/index.do?menu_idx=73&page=2"
f portal_news "https://library.busan.go.kr/portal/board/index.do?menu_idx=27&manage_idx=24"
f pen_bujun "https://home.pen.go.kr/bujunlib/"
f pen_dep17 "https://www.pen.go.kr/dep17/na/ntt/selectNttList.do?mi=31242&bbsId=2579"
