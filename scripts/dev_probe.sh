#!/usr/bin/env bash
# (임시) 지역아동센터 1차: 부산지원단 인재채용·아동권리보장원 구인게시판
f() { python scripts/dev_fetch.py "$@" || true; }
f bro3c_hire "https://www.bro3c.org/5_4"
f bro3c_main "https://www.bro3c.org/"
f icare_list "https://www.icareinfo.go.kr/notice/jobOffer/jobOfferList.do"
f city_children "https://www.busan.go.kr/depart/children0701"
