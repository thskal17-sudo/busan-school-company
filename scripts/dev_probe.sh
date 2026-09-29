#!/usr/bin/env bash
# (임시) 여성인력개발센터 5곳 시험 수집 (상세 페이지 포함)
f() { python scripts/dev_fetch.py "$@" || true; }
f saha_notice "https://www.sahawcenter.or.kr/sub5/sub1.aspx"
IDS="bswoman_notice dongnae_woman_notice hwcenter_notice donggu_woman_notice saha_woman_notice"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패"
