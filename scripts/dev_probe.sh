#!/usr/bin/env bash
# (임시) 복지관 3차: 부산시 노인복지관·장애인복지관 현황 (홈페이지 목록)
f() { python scripts/dev_fetch.py "$@" || true; }
f city_senior "https://www.busan.go.kr/depart/welgrand030401"
f city_disabled "https://www.busan.go.kr/depart/weldisabled0303"
f city_facility "https://www.busan.go.kr/welfare/ahfacilitystauts"
f baswc_members "https://www.baswc.org/"
