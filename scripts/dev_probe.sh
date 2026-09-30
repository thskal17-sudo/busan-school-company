#!/usr/bin/env bash
# (임시) 지역아동센터 2차: 아동권리보장원 부산 필터·상세 GET, 부산지원단 상세
f() { python scripts/dev_fetch.py "$@" || true; }
f icare_busan "https://www.icareinfo.go.kr/notice/jobOffer/jobOfferList.do?menuNo=3001110&searchCondition3=%EB%B6%80%EC%82%B0&pageIndex=1"
f icare_busan_post "https://www.icareinfo.go.kr/notice/jobOffer/jobOfferList.do" "post:menuNo=3001110&bbs_section_cd=job&pageIndex=1&searchCondition3=부산"
f icare_detail "https://www.icareinfo.go.kr/notice/jobOffer/jobOfferDetail.do?bbs_no=17733&menuNo=3001110&bbs_section_cd=job"
f bro3c_detail "https://www.bro3c.org/5_4/73989"
f bro3c_p2 "https://www.bro3c.org/5_4?page=2"
