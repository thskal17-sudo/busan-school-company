#!/usr/bin/env bash
# (임시) 문화센터 4차: 기장문화원 공지
f() { python scripts/dev_fetch.py "$@" || true; }
f l_gijangcc "http://gijangcc.or.kr/yard_2/01.php"
