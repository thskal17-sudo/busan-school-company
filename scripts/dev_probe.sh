#!/usr/bin/env bash
# (임시) 청소년수련관 게시판 조사 1차: 시설 목록, 청소년활동진흥센터 채용정보
f() { python scripts/dev_fetch.py "$@" || true; }
f yc_dir "https://www.busanyouth.net/sub/template.php?midx=55"
f yc_hire "https://www.busanyouth.net/sub/template.php?midx=138"
f yc_hire2 "https://www.busanyouth.net/sub/template.php?midx=138&page=2"
f bsyouth "http://www.bsyouth.or.kr/"
f ymcahy "http://www.ymcahy.or.kr/"
f power0924 "https://www.power0924.org/"
f teenstory "https://teenstory.kr/"
f yzzang "http://www.yzzang.com/"
