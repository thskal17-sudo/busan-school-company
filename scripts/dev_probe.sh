#!/usr/bin/env bash
# (임시) 문화예술교육 기관 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
f becs_5265 "https://home.pen.go.kr/becs/na/ntt/selectNttList.do?mi=10258&bbsId=5265"
python -m busan_jobs check-source culture_bsarte_notice pen_bacs_notice pen_becs_notice pen_bsec_notice > probe_out/check.txt 2>&1 || true
