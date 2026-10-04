#!/usr/bin/env bash
# (임시) 육아종합지원센터 게시판 조사 5차: 시험 수집 (북구·동래·강서)
python -m busan_jobs check-source childcare_bukgu_notice childcare_dongnae_notice childcare_gangseo_notice > probe_out/check.txt 2>&1 || true
grep -E "^===|목록|오류" probe_out/check.txt
