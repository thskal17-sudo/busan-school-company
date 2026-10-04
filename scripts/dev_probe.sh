#!/usr/bin/env bash
# (임시) 아동보호전문기관 게시판 조사 3차: 시험 수집 + 동부산 상세 주소
f() { python scripts/dev_fetch.py "$@" || true; }
f db_view "http://dbchild.saem.or.kr/community/notice-3/?lhwb_mode=view&board_id=9&list_id=230819"
python -m busan_jobs check-source cpa_bukbusan_notice cpa_dongbusan_notice cpa_jungbusan_notice > probe_out/check.txt 2>&1 || true
grep -E "^===|목록|오류" probe_out/check.txt
