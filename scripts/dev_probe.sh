#!/usr/bin/env bash
# (임시) 어린이집 게시판 조사 2차: 시험 수집 (3쪽, offset)
python -m busan_jobs check-source childcare_daycare_joboffer > probe_out/check.txt 2>&1 || true
grep -E "^===|목록|오류" probe_out/check.txt
grep -c "JOSEQ=" probe_out/check.txt
