#!/usr/bin/env bash
# (임시) 건강가정지원센터 게시판 조사 2차: 진흥원 '여평원 수탁기관' 게시판, 제목 '강사' 검색
f() { python scripts/dev_fetch.py "$@" || true; }
K=%EA%B0%95%EC%82%AC  # 강사
B=https://www.bgli.re.kr/kor/CMS/Board/Board.do
f bgli_trust "$B?mCode=MN162"
f bgli_trust_p2 "$B?mCode=MN162&page=2"
f bgli_trust_s "$B?mCode=MN162&mode=list&searchID=title&searchKeyword=$K"
f bgli_notice_s "$B?mCode=MN083&mode=list&mgr_seq=16&searchID=title&searchKeyword=$K"
f bgli_hire_s "$B?mCode=MN084&mode=list&searchID=title&searchKeyword=$K"
