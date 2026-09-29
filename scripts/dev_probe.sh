#!/usr/bin/env bash
# (임시) 청소년문화의집 3차: 새 소스 시험 수집 + 기장청소년센터 첫 화면
f() { python scripts/dev_fetch.py "$@" || true; }
f gijang_main_http "http://www.gijangcmc.or.kr/youthcenter/main/main.asp"
f bujeon_list "https://teenstory.kr/xe/sub7_01"
f saha_list "http://sahayouth.or.kr/sb71.php"
f haeundae_list "https://www.haeundae.go.kr/young/board/list.do?boardId=BBS_0000300&menuCd=DOM_000001305001000000"
IDS="gaya_youth_notice bujeon_youth_notice bkyouth_notice sahayouth_notice seoguyouth_notice seeyouth_notice purun1318_notice haeundae_youth_notice"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
python -m busan_jobs run --no-mail --db probe_out/test.db --out probe_out/out --source $IDS 2>&1 | grep -E "^\[|^신규|WARNING|상세 페이지 실패"
