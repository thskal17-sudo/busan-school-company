#!/usr/bin/env bash
# (임시) 수영장 3차: 새 게시판 시험 수집
python -m busan_jobs check-source pool_spo1_notice pool_sasang_hire pool_myeongji_hire > probe_out/check.txt 2>&1
grep -E "^===|목록 |오류|\[모집중|\[결과공고" probe_out/check.txt
