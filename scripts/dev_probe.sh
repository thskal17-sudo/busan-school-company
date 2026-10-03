#!/usr/bin/env bash
# (임시) 장애인복지관 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }

f d_sigak "https://www.newwhite.or.kr/"
f d_seogu "http://www.seogurc.or.kr/"
f d_donggu "http://www.dgwc.or.kr/"
f d_yeongdo "https://www.yeongdorc.or.kr/"
f d_busanjin "https://bokji.chambokji.org/"
f d_namgu "http://www.namgurc.or.kr/"
f d_nasaham "https://www.nasaham.or.kr/"
f d_haeundae "http://togetherhaeundae.or.kr/"
f d_haeundae2 "http://www.xn--zb0b0hu1mm1l3rkh3bkxbiky5n1p9a.kr/"
f d_saha "http://saharc.or.kr/main/main.html"
f d_geumjeong "https://www.gjrc.or.kr/"
f d_suyeong "http://syrc.or.kr/"
f d_sasang "http://www.sasangrc.or.kr/"
f d_gijang "https://www.gijangbok.or.kr/"
f d_family "https://bsfamily.co.kr/5-3"
