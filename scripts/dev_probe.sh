#!/usr/bin/env bash
# (임시) 복지관 8차: 북구장애인종합복지관 채용게시판 (오래된 TLS)
f() { python scripts/dev_fetch.py "$@" || true; }
f bgrc_list "https://bgrc.or.kr/community_05.html" legacy
f bgrc_list2 "https://bgrc.or.kr/community_05.html?table=LimBo&botype=LIS_B01_05" legacy
f bgrc_http "http://bgrc.or.kr/community_05.html?table=LimBo&botype=LIS_B01_05"
