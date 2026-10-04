#!/usr/bin/env bash
# (임시) 육아종합지원센터 게시판 조사 2차: 구 센터 공지사항, 제목 '강사' 검색
f() { python scripts/dev_fetch.py "$@" || true; }
K=%EA%B0%95%EC%82%AC  # 강사
C=https://busan.childcare.go.kr/ccef/community/notice/NoticeSlPL.jsp
f cc_notice_s "$C?BBSGB=47&SCHBTITLE=$K"
f cc_hire_s "$C?BBSGB=1233&SCHBTITLE=$K"
nb() { f "nt_$1" "$2"; f "ns_$1" "$2&search=&SearchString=$K"; }
nb bjscfc "https://www.bjscfc.or.kr/board/list.asp?BoardID=0001"
nb gijang "https://gijangchild.or.kr/board/list.asp?BoardID=0001"
nb sasang "https://www.sasangicare.kr/board/list.asp?BoardID=0001"
nb bsscc "https://www.bsscc.or.kr/community/board_list.asp?BoardID=0003"
nb bsyscc "https://www.bsyscc.or.kr/new/board/list.asp?BoardID=0001"
nb gjscc "https://www.gjscc.or.kr/community/board_list.asp?BoardID=0004"
nb sahascc "https://www.sahascc.or.kr/community/board_list.asp?BoardID=0004"
nb ydgscc "https://www.ydgscc.or.kr/community/board_list.asp?BoardID=0003"
f nt_ecohud "https://www.ecohud.or.kr/05/01.php"
f home_yjscfc "https://www.yjscfc.or.kr/"
f home_bdscc "https://bdscc.or.kr/"
f home_bdscc_http "http://bdscc.or.kr/"
f home_bbgscc_www "https://www.bbgscc.or.kr/"
f home_bgscc_http "http://www.bgscc.or.kr/"
