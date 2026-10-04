#!/usr/bin/env bash
# (임시) 건강가정지원센터 게시판 조사 3차: 시험 수집
python -m busan_jobs check-source bgli_notice bgli_trust > probe_out/check.txt 2>&1 || true
grep -E "^===|목록|오류" probe_out/check.txt
