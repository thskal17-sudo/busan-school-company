#!/usr/bin/env bash
# (임시) 문화센터 게시판 조사 2-3차: 시험 수집
python -m busan_jobs check-source media_kcmf_busan_notice hall_dureraum_notice hall_gugak_notice hall_gugak_hire hall_bma_notice > probe_out/check.txt 2>&1 || true
grep -E "^===|목록|오류|\[ *(모집중|결과)" probe_out/check.txt | head -60
