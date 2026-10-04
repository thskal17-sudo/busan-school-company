#!/usr/bin/env bash
# (임시) 건강가정지원센터 게시판 조사: 위탁 기관(부산여성가족과평생교육진흥원) 공지사항, familynet 재확인
f() { python scripts/dev_fetch.py "$@" || true; }
f bgli_notice "https://www.bgli.re.kr/kor/CMS/Board/Board.do?mCode=MN083"
f bgli_notice_p2 "https://www.bgli.re.kr/kor/CMS/Board/Board.do?mCode=MN083&page=2"
f bgli_hfsc "https://www.bgli.re.kr/kor/CMS/Contents/Contents.do?mCode=MN049"
f fn_bsfc "https://bsfc.familynet.or.kr/center/index.do"
f fn_busanjin "https://busanjin.familynet.or.kr/center/"
