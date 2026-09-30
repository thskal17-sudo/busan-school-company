#!/usr/bin/env bash
# (임시) 복지관 7차: 새 소스 전체 시험 수집
IDS="baswc_hire bswin_job senior_busanjin_hire senior_city_recruit senior_city_notice senior_dasarang_notice senior_gangseo_notice senior_geumjeong_notice senior_gwangan_notice senior_jasungdae_notice senior_junggu_notice senior_munhyeon_notice senior_myeongji_recruit senior_ojin_recruit senior_sasang_hire senior_sasang_branch_hire senior_silverbell_hire senior_suyeong_hire senior_yeongdo_notice senior_yeonje_notice senior_seogu_notice senior_namgu_hire senior_bumin_notice senior_saha_notice rehab_hire bgrc_hire dnrc_notice busancp_notice"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패|^  \["
