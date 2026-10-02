#!/usr/bin/env bash
# (임시) 체육센터 5차: 새 게시판 시험 수집
python -m busan_jobs check-source sports_busanjin_hire sports_yeonje_hire sports_geoje_hire sports_suyeong_hire sports_suyeong_club_hire sports_saha_notice assoc_city_notice assoc_busanjin_hire assoc_namgu_hire assoc_gangseo_hire assoc_junggu_notice assoc_junggu_hire assoc_saha_hire assoc_suyeong_hire assoc_seogu_notice assoc_haeundae_hire assoc_yeongdo_hire assoc_bukgu_notice  dongnae_sports_hire > probe_out/check.txt 2>&1
grep -E "^===|목록 |오류|\[모집중|\[결과공고" probe_out/check.txt
