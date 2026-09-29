#!/usr/bin/env bash
# (임시) 부산 게시판 조사 1차: 기관 첫 화면을 받아 메뉴에서 게시판 주소를 찾는다
f() { python scripts/dev_fetch.py "$@" || true; }
f pen https://www.pen.go.kr/
f busan https://www.busan.go.kr/
f bisco https://www.bisco.or.kr/
f junggu https://www.bsjunggu.go.kr/
f seogu https://www.bsseogu.go.kr/
f donggu https://www.bsdonggu.go.kr/
f donggu2 https://www.bs.go.kr/
f yeongdo https://www.yeongdo.go.kr/
f busanjin https://www.busanjin.go.kr/
f dongnae https://www.dongnae.go.kr/
f namgu https://www.bsnamgu.go.kr/
f bukgu https://www.bsbukgu.go.kr/
f haeundae https://www.haeundae.go.kr/
f saha https://www.saha.go.kr/
f geumjeong https://www.geumjeong.go.kr/
f gangseo https://www.bsgangseo.go.kr/
f yeonje https://www.yeonje.go.kr/
f suyeong https://www.suyeong.go.kr/
f sasang https://www.sasang.go.kr/
f gijang https://www.gijang.go.kr/
f bepa https://www.bepa.kr/
f gojobs "https://www.gojobs.go.kr/apmList.do?menuNo=401&searchJobsecode=020&searchSelectninsttnm=%EB%B6%80%EC%82%B0&pageIndex=1"
f alio https://job.alio.go.kr/recruit.do
python -m busan_jobs check-source gojobs_list || true
