#!/usr/bin/env bash
# (임시) 장난감도서관 게시판 조사 3차: 시험 수집
python -m busan_jobs check-source toy_dongnae_momshug_notice > probe_out/check.txt 2>&1 || true
grep -E "^===|목록|오류|view.asp" probe_out/check.txt | head -6
