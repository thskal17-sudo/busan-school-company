#!/usr/bin/env bash
# (임시) 육아종합지원센터 게시판 조사 1차
f() { python scripts/dev_fetch.py "$@" || true; }
C=https://busan.childcare.go.kr
f robots_cc "$C/robots.txt"
f cc_notice "$C/ccef/community/notice/NoticeSlPL.jsp?BBSGB=47"
f cc_hire "$C/ccef/community/notice/NoticeSlPL.jsp?BBSGB=1233"
f cc_joboffer "$C/ccef/job/JobOfferSlPL.jsp?flag=SlPL"
f cc_centers "$C/lbusan/d3_40020/d3_40027/d3_40029.jsp"
for h in www.bjscfc.or.kr gijangchild.or.kr www.bsscc.or.kr www.bsyscc.or.kr www.sahascc.or.kr www.gjscc.or.kr bbgscc.or.kr www.bgscc.or.kr www.sasangicare.kr www.ecohud.or.kr www.ydgscc.or.kr; do
  n=$(echo "$h" | sed 's/^www\.//; s/\..*//')
  f "home_$n" "https://$h/"
done
