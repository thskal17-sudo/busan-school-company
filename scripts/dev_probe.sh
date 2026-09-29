#!/usr/bin/env bash
# (임시) 청소년문화의집 2차: 공지·채용 게시판 목록
f() { python scripts/dev_fetch.py "$@" || true; }
f gijang_main "https://www.gijangcmc.or.kr/youthcenter/main/main.asp"
f gaya_notice "http://gayayouth.or.kr/p41.php"
f bujeon_xe "http://teenstory.kr/xe"
f jeonpo_ua "https://www.jinguzzang.com/" ua
f jeonpo_http "http://www.jinguzzang.com/" ua
f jeonpo_nowww "https://jinguzzang.com/" ua
f bukgu_notice "http://bkyouth.or.kr/notice"
f saha_nowww "http://sahayouth.or.kr/"
f saha_again "http://www.sahayouth.or.kr/"
f seogu_notice "https://www.seoguyouth.co.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f seogu_news "https://www.seoguyouth.co.kr/SW_bbs/notice/list.php?zipEncode===qzJLgDV50yH91vt1drjrMCH9MyMetpSfMvWLME"
f suyeong_n1 "http://www.seeyouth.or.kr/SW_bbs/notice/list.php?zipEncode==W2BVH2yZ91vt1drjrMCH9MyMetpSfMvWLME"
f suyeong_n2 "http://www.seeyouth.or.kr/SW_bbs/notice/list.php?zipEncode=5f2CFv2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f suyeong_n3 "http://www.seeyouth.or.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f junggu_51 "https://purun1318.org/sb51.php"
f junggu_71 "https://purun1318.org/sb71.php"
f haeundae_notice "https://www.haeundae.go.kr/young/index.do?menuCd=DOM_000001305001000000"
