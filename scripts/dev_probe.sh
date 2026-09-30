#!/usr/bin/env bash
# (임시) 도서관 6차: 새 도서관 게시판 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
python -m busan_jobs check-source lib_bansong lib_english lib_gudeok lib_gupo lib_myeongjang lib_saha lib_seodong lib_yeonsan lib_joongang lib_haeundae lib_dadae lib_hadan lib_gj_gijang lib_gj_jeonggwan lib_gj_jgchild lib_gj_gochon lib_gj_naeri lib_gj_gyori lib_gj_ilgwang lib_gj_igchild lib_dongnae lib_allak lib_gs_miracle lib_gs_gangseo lib_gs_jisa lib_geumsaem lib_geumgok lib_deokcheon lib_hwamyeong lib_mandeok lib_donggu lib_donggu_english lib_busanjin lib_sasang lib_jurye lib_seogu_ami lib_yeongdo lib_yeongdo_namhang lib_yeonje lib_yeonje_manhwa  2>&1 | tail -n 400
for c in jgchildlib ilgwang igchildlib; do f "gj_$c" "https://library.gijang.go.kr/$c/bbs/list.do?ptIdx=207&mId=0501000000"; done
f gj_naeri "https://library.gijang.go.kr/naeri/bbs/list.do?ptIdx=207&mId=0401000000"
f hd_library "https://www.haeundae.go.kr/library/index.do"
f hd_library_http "http://www.haeundae.go.kr/library"
