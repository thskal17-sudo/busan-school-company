#!/usr/bin/env bash
# (임시) 청소년상담복지센터 5차: 사하·기장 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
f gijang1388_notice "https://www.gijangcmc.or.kr/1388/04_notice/notice01.asp?id=Notice&wr_7=%C3%BB%BC%D2%B3%E2%BB%F3%B4%E3%BA%B9%C1%F6"
python -m busan_jobs check-source saha1388_notice gijang1388_notice 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source saha1388_notice gijang1388_notice 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패"
