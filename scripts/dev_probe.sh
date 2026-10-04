#!/usr/bin/env bash
# (임시) 다문화가족지원센터(가족센터) 조사 5차: 시험 수집
python -m busan_jobs check-source family_danuri_hire > probe_out/check.txt 2>&1 || true
head -40 probe_out/check.txt
