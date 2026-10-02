#!/usr/bin/env bash
# (임시) 문화센터 5차: 새 게시판 시험 수집
python -m busan_jobs check-source culture_junggu_notice culture_seogu_notice culture_donggu_notice culture_busanjin_notice culture_dongnae_notice culture_namgu_notice culture_haeundae_notice culture_saha_notice culture_geumjeong_notice culture_gijang_notice hall_bscc_news hall_dongnae_notice hall_geumjeong_notice hall_gjfac_notice hall_gjfac_hire  > probe_out/check.txt 2>&1
grep -E "^===|목록 |오류|\[모집중|\[결과공고" probe_out/check.txt
