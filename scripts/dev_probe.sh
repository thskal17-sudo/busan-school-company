#!/usr/bin/env bash
# (임시) 복지관 2차: 노인복지시설협회 구인 목록 + 새 소스 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
f bfsw_jb01 "https://www.bfsw.kr/hwjb/jb01_list.php"
IDS="baswc_hire bswin_job"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패|^  \["
