#!/usr/bin/env bash
# (임시) 주민자치센터(동 행정복지센터) 게시판 조사 5차: 시험 수집 + 지난 강사 모집 글 검색
f() { python scripts/dev_fetch.py "$@" || true; }
K=%EA%B0%95%EC%82%AC  # 강사

f bsj_s "https://www.busanjin.go.kr/board/list.busanjin?boardId=DONGNOTICE&searchType=DATA_TITLE&keyword=$K"
f nm_s "https://www.bsnamgu.go.kr/board/list.namgu?boardId=BBS_0000123&searchType=DATA_TITLE&keyword=$K"
f bk_s "https://www.bsbukgu.go.kr/board/list.bsbukgu?boardId=BBS_0000125&searchType=DATA_TITLE&keyword=$K"
f ss_s "https://www.sasang.go.kr/board/list.sasang?boardId=BBS_0000173&searchType=DATA_TITLE&keyword=$K"
f gs_s "https://www.bsgangseo.go.kr/portal/board/post/list.do?bcIdx=543&mid=0604010200&searchType=0&searchTxt=$K"
f gs_view "https://www.bsgangseo.go.kr/portal/board/post/view.do?idx=409809&bcIdx=543&mid=0604010200"
f bsj_p2 "https://www.busanjin.go.kr/board/list.busanjin?boardId=DONGNOTICE&startPage=2"
f busan_city "https://www.busan.go.kr/depart/jobgonji01"

python -m busan_jobs check-source dong_busanjin_notice dong_namgu_notice dong_bukgu_notice dong_sasang_notice dong_gangseo_notice > probe_out/check.txt 2>&1 || true
tail -60 probe_out/check.txt
