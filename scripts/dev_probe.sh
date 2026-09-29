#!/usr/bin/env bash
# (임시) 청소년문화의집 5차: 새 소스 전체 시험 수집 (부전은 접속 제한이 있어 run 한 번만)
IDS="gaya_youth_notice bujeon_youth_notice bkyouth_notice sahayouth_notice seoguyouth_notice seeyouth_notice purun1318_notice haeundae_youth_notice gijang_youth_notice"
python -m busan_jobs check-source gijang_youth_notice 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패|^  \["
