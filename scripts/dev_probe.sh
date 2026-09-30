#!/usr/bin/env bash
# (임시) 도서관 8차: 구청 계열 도서관 게시판 시험 수집 (러너 세 대에서 따로)
for h in www.saha.go.kr www.bsbukgu.go.kr www.yeonje.go.kr dongnae.go.kr home.pen.go.kr library.gijang.go.kr; do curl -s -m 12 -o /dev/null -w "$h %{http_code} %{time_total}s\n" "https://$h/" || echo "$h 실패"; done
python -m busan_jobs check-source lib_dadae lib_hadan lib_dongnae lib_allak lib_gs_miracle lib_gs_gangseo lib_gs_jisa lib_geumsaem lib_geumgok lib_deokcheon lib_hwamyeong lib_mandeok lib_donggu lib_donggu_english lib_busanjin lib_sasang lib_jurye lib_seogu_ami lib_yeongdo lib_yeongdo_namhang lib_yeonje lib_yeonje_manhwa  > probe_out/check.txt 2>&1
grep -E "^===|목록|오류|\[ (신규|모집중|진행중|결과공고) \]" probe_out/check.txt
