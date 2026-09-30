#!/usr/bin/env bash
# (임시) 복지관 6차: 형식이 불확실한 목록들
f() { python scripts/dev_fetch.py "$@" || true; }
f sb_namgu_hire "http://www.ngswc.or.kr/04_notice/notice05.php"
f sb_bumin "https://www.bmsenior.org/SW_bbs/notice/list.php?zipEncode==etpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
f sb_saha_ajax "https://sahasilver.org/07/01.php?mode=list_ok&skind=&skey=&search=&page=1" "post:"
f sb_saha_view "https://sahasilver.org/07/01.php?mode=view&uid=734"
f sb_ojin_read "http://ojin.saem.or.kr/community/guest/?mode=read&dir=read&number=22251"
f dis_rehab_hire "https://www.rehabcenter.or.kr/SW_bbs/notice/list.php?zipEncode==i2BQ91vt1drjrMCH9MyMetpSfMvWLME"
f dis_bgrc_hire "https://bgrc.or.kr/community_05.html"
f dis_bgrc_main "https://bgrc.or.kr/"
f dis_dnrc_notice "https://dnrc.kr/notice"
f dis_busancp "http://www.busancp.or.kr/"
f dis_bdac "https://bdac.or.kr/"
