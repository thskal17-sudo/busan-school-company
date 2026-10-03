#!/usr/bin/env bash
# (임시) 청소년 기관 게시판 시험 수집
python -m busan_jobs check-source youth_assoc_hire youth_say_notice youth_onestop_notice > probe_out/check.txt 2>&1 || true
curl -s -o /dev/null -m 20 -w "busan.go.kr https %{http_code} %{time_total}s\n" https://www.busan.go.kr/ > probe_out/city.txt 2>&1 || echo "busan.go.kr 실패" >> probe_out/city.txt
