#!/usr/bin/env bash
# (임시) 도서관 7차: 구청 계열 도서관 게시판 다시 시험 수집 (6차 러너는 구청 서버가 모두 시간 초과)
curl -s -m 10 -o /dev/null -w "saha %{http_code}\n" https://www.saha.go.kr/ || true
python -m busan_jobs check-source lib_dadae lib_hadan lib_dongnae lib_allak lib_gs_miracle lib_gs_gangseo lib_gs_jisa lib_geumsaem lib_geumgok lib_deokcheon lib_hwamyeong lib_mandeok lib_donggu lib_donggu_english lib_busanjin lib_sasang lib_jurye lib_seogu_ami lib_yeongdo lib_yeongdo_namhang lib_yeonje lib_yeonje_manhwa  > probe_out/check.txt 2>&1
grep -E "^===|목록|오류|\[ (신규|모집중|진행중|결과공고) \]" probe_out/check.txt
