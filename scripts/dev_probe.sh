#!/usr/bin/env bash
# (임시) 도서관 3차: 공공도서관 누리집 첫 화면
f() { python scripts/dev_fetch.py "$@" || true; }
for c in bansonglib bellib bujunlib guducklib haeundaelib mjlib sahalib seodonglib yeonsanlib; do
  f "pen_$c" "https://home.pen.go.kr/$c/main.do"
done
f pen_joongang "https://home.pen.go.kr/joonganglib/main.do"
f gupolib "http://www.gupolib.or.kr/"
f dadaelib "http://dadaelib.saha.go.kr"
f hadanlib "https://www.saha.go.kr/hadanlib/main.do"
f gijang_dlib "https://dlib.gijang.go.kr/gyori/main.do"
f gijang_lib "https://library.gijang.go.kr/gochon/main.do"
f dongnae_lib "https://dongnae.go.kr/lib/dongnae/"
f gangseo_lib "https://library.bsgangseo.go.kr/gmlib/"
f namgu_lib "http://library.bsnamgu.go.kr/"
f geumjeong_lib "http://library.geumjeong.go.kr/"
f geumsaem_lib "https://www.geumjeong.go.kr/gslib/index.geumj"
f bukgu_lib "https://www.bsbukgu.go.kr/bglib/index.bsbukgu"
f donggu_lib "http://www.bsdonggu.go.kr/library/index.donggu"
f seogu_lib "https://www.bsseogu.go.kr/amlib/main.do"
f busanjin_lib "https://www.busanjin.go.kr/library"
f haeundae_lib "http://www.haeundae.go.kr/library"
f sasang_lib "http://www.sasang.go.kr/library"
f yeongdo_lib "http://www.yeongdo.go.kr/library.web"
f yeonje_lib "https://www.yeonje.go.kr/library/main.do"
