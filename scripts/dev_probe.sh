#!/usr/bin/env bash
# (임시) 시각장애인복지관 상세 주소 확인
f() { python scripts/dev_fetch.py "$@" || true; }
f sigak_view1 "https://www.newwhite.or.kr/boardView.do?BNUM=201512011&SEQ=20261001155552&leftMenuNum=1&parentMenuNum=3&reqPage=1&imgNum=1"
f sigak_view2 "https://www.newwhite.or.kr/boardView.do?BNUM=201512011&SEQ=20261001155552&leftMenuNum=1&leftMenuTitle=%EB%B3%B5%EC%A7%80%EA%B4%80%EC%86%8C%EC%8B%9D&parentMenuNum=3&BTYPE=&reqPage=1&imgNum=1"
