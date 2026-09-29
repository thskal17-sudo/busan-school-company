#!/usr/bin/env bash
# (임시) 청소년문화의집 4차: 해운대 글 주소 형식, 부전 접속 안정성, 기장청소년센터 새소식
f() { python scripts/dev_fetch.py "$@" || true; }
Q="boardId=BBS_0000300&menuCd=DOM_000001305001000000&paging=ok&startPage=1&dataSid=3155951"
f hd_young "https://www.haeundae.go.kr/young/board/view.do?$Q"
f hd_root "https://www.haeundae.go.kr/board/view.do?$Q"
f hd_library "https://www.haeundae.go.kr/library/board/view.do?$Q"
f hd_reserve "https://www.haeundae.go.kr/reserve/board/view.do?$Q"
f hd_young_short "https://www.haeundae.go.kr/young/board/view.do?boardId=BBS_0000300&menuCd=DOM_000001305001000000&dataSid=3155951"
f bujeon_1 "https://teenstory.kr/xe/sub7_01"
f bujeon_http "http://teenstory.kr/xe/sub7_01"
f bujeon_detail "https://teenstory.kr/xe/sub7_01/24564"
sleep 30
f bujeon_2 "https://teenstory.kr/xe/sub7_01"
f gj_notice "https://www.gijangcmc.or.kr/youthcenter/01_info/01_info.asp?id=Notice&wr_7=%B1%E2%C0%E5%C3%BB%BC%D2%B3%E2%BC%BE%C5%CD"
f gj_info "https://www.gijangcmc.or.kr/youthcenter/01_info/01_info.asp"
python -m busan_jobs check-source bujeon_youth_notice 2>&1 | grep -E "^===|목록|오류|실패"
