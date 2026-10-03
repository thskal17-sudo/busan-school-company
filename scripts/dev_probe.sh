#!/usr/bin/env bash
# (임시) 노인복지관 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }

f dnswc_home "https://www.dnswc.or.kr/"
f jangsan_home "http://www.haeundaejangsan.or.kr/"
f jangsan_home_s "https://www.haeundaejangsan.or.kr/"
f sjr_home "http://www.sjrsilver.or.kr/" ua
f bfsw_jb02 "https://www.bfsw.kr/hwjb/jb02_list.php"
f bfsw_home "https://www.bfsw.kr/"
# 이미 받는 복지관의 다른 게시판
f busanjin_notice "https://www.chambokji.org/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f ojin_notice "http://ojin.saem.or.kr/community/notice/"
f sasang_notice "http://www.sasang-senior.or.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f sasang_branch_notice "http://www.sasang-senior.or.kr/SW_bbs/notice/list.php?zipEncode=Yu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f silverbell_notice "http://www.xn--hk3bqct1u.kr/html/index.php?pageNum=005001000"
f suyeong_notice "https://6070.bulgukto.or.kr/SW_bbs/notice/list.php?zipEncode==etpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f myeongji_notice "http://mjnoin.ai-sw.net/bbs/board.php?bo_table=notice"
f dasarang_notice3 "http://www.xn--9i1b2b12rnnlbwc3yf.org/board/bbs/board.php?bo_table=notice3"
f namgu_home "http://www.ngswc.or.kr/"
f seogu_home "https://www.bssgsenior.or.kr/"
