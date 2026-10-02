#!/usr/bin/env bash
# (임시) 종합사회복지관 9차: 시간 초과였던 게시판 다시
python -m busan_jobs check-source cw_jangseon_notice cw_jangseon_hire cw_gijang_notice cw_dahaengbok_notice gijang_youth_notice > probe_out/check.txt 2>&1
grep -E "^===|목록 |오류|\[(모집중|결과공고)" probe_out/check.txt
python scripts/dev_fetch.py f19n "http://hwajung.saem.or.kr/community/news1.php" || true
