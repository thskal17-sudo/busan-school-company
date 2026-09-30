#!/usr/bin/env bash
# (임시) 지역아동센터 3차: 시험 수집
IDS="bro3c_hire icare_busan_hire"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패|^  \["
