#!/usr/bin/env bash
# (임시) 청소년수련관 5차: 함지골 공지 목록 + 청소년 소스 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
f hamji_list "http://www.hamji.or.kr/skin_build61/bbs_list.php?unsingcode1=1185858166&unsingcode2=1185859331&code=notice"
f gd_notice "https://gudeok.or.kr/sb51.php"
IDS="busanyouth_hire busanyouth_notice youthcool_notice onnainna_hire onnainna_notice power0924_notice kumgok_notice yzzang_hire yzzang_notice gudeok_notice"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패"
