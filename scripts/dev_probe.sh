#!/usr/bin/env bash
# (임시) 종합사회복지관 1차: 회원기관 목록
f() { python scripts/dev_fetch.py "$@" || true; }
f baswc_list "https://www.baswc.org/guide/sub2.php"
f baswc_list_p2 "https://www.baswc.org/guide/sub2.php?page=2"
f baswc_intro "https://www.baswc.org/guide/sub1.php"
f city_welfare "https://www.busan.go.kr/depart/welfare0301"
