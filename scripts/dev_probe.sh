#!/usr/bin/env bash
# (임시) 종합사회복지관 5차: 공지·채용 게시판 목록, 막힌 첫 화면 다시
f() { python scripts/dev_fetch.py "$@" || true; }
N='==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME'      # SW_bbs 공지사항
H='==i2BQ91vt1drjrMCH9MyMetpSfMvWLME'          # SW_bbs 채용
sw() { f "$1" "$2/SW_bbs/notice/list.php?zipEncode=$3"; }
sw2() { f "$1" "$2/SW_bbs/list.php?zipEncode=$3"; }
sw b01n https://www.gangseosw.or.kr "$N"
sw b01h https://www.gangseosw.or.kr "ZDxzU91vt1drjrMCH9MyMetpSfMvWLME"
f b02n "https://www.ndswc.or.kr/06/01.php"
sw b03n https://www.kumjungswc.or.kr "$N"
sw2 b04n https://www.nk.or.kr "$N"
f b05m "http://www.gamman.or.kr/main/main.php"
sw2 b07n https://www.yongho.or.kr "$N"
sw b08n https://www.chorogusan-busan.or.kr "$N"
f b09m "https://www.dongguswc.or.kr/" ua
sw b11n https://www.sjcwc.org "==etpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
sw b11n2 https://www.sjcwc.org "$N"
sw b12n http://www.yjingu.or.kr "$N"
sw b13n https://anguk.gaegeum.org "===qm9ugDHnezYf2BIzczUv3BZ91vt1drjrMCH9MyMetpSfMvWLME"
sw b13n2 https://anguk.gaegeum.org "===azUv3BZ91vt1drjrMCH9MyMetpSfMvWLME"
f b14n "https://www.danggam.or.kr/notice"
f b14h "https://www.danggam.or.kr/recruit"
sw b15n https://www.jpswc.or.kr "$N"
f b16n "https://www.jsswc.or.kr/html/index.php?pageNum=002001000"
f b16h "https://www.jsswc.or.kr/html/index.php?pageNum=002012000"
f b17m "http://www.geumgok.or.kr/" ua
f b18n "http://www.duc1000.co.kr/notice"
f b19m "http://hwajung.saem.or.kr/main/main.php"
sw b20n http://www.gongchang.or.kr "==etpLrxydrMCH9MyMu2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
sw b20n2 http://www.gongchang.or.kr "$N"
f b21n "http://www.ymcadw.org/03_dongwon/list.asp?data_id=0"
f b22n "https://www.nsjswc.co.kr/bbs/sub4_1"
f b23n "http://www.hmswc2233.or.kr/notice"
f b23h "http://www.hmswc2233.or.kr/bulletin"
f b23p "http://www.hmswc2233.or.kr/program"
f b24n "https://mandeok07.org/%ec%b0%b8%ec%97%ac%eb%a7%88%eb%8b%b9/%ea%b3%b5%ec%a7%80%ec%82%ac%ed%95%ad/"
f b24h "https://mandeok07.org/%ec%b0%b8%ec%97%ac%eb%a7%88%eb%8b%b9/%ec%b1%84%ec%9a%a9-%ea%b3%b5%ea%b3%a0/"
sw b25n https://www.moraswc.or.kr "$N"
sw b26n https://www.swc.or.kr "$N"
f b27m "http://www.bysw.or.kr/" ua
sw2 b28n http://www.hakjang.or.kr "$N"
sw2 b28h http://www.hakjang.or.kr "$H"
f b29n "http://www.sahabokji.or.kr/05/01.php"
f b30m "http://www.dadaeswc.or.kr/" ua
f b31m "http://www.dusong.or.kr/" ua
f b33n "https://www.gupyung.or.kr/bbs/board.php?bo_table=news"
f b34m "https://www.lovesw.or.kr/" ua
sw b35n https://www.pseogu.or.kr "$N"
f b36m "https://rosabusan.org/" ua
sw b37n https://www.holtsy.or.kr "$N"
sw b37h https://www.holtsy.or.kr "$H"
sw b39n http://www.youngdogu.or.kr "$N"
sw b39h http://www.youngdogu.or.kr "==0MCVzMBP91vt1drjrMCH9MyMetpSfMvWLME"
sw b40n https://www.dscwc.or.kr "$N"
sw2 b41n https://www.jy.or.kr "$N"
f b42n "https://www.sangli.org/bbs/board.php?bo_table=notice"
sw2 b43n https://www.wachi.or.kr "$N"
sw b44n http://www.jungbok.or.kr "$N"
f b45m "https://www.yjswc.or.kr/renewal/main/main.php"
f b46m "http://haeundae.saem.or.kr/main/main.php"
f b47m "https://www.bsymca.org/" ua
sw b48n https://www.woon-bong.or.kr "$N"
sw b48h https://www.woon-bong.or.kr "$H"
sw2 b49n http://www.banseok1995.or.kr "$N"
f b50n "http://www.sungsil.or.kr/bbs/board.php?bo_table=notice"
f b50h "http://www.sungsil.or.kr/bbs/board.php?bo_table=reqruit"
f b51n "https://www.ebanyeo.com/bbs/board.php?bo_table=notice"
f b51g "https://www.ebanyeo.com/bbs/board.php?bo_table=notice_gosi"
f b52n "https://www.gijangcmc.or.kr/welfare/01_info/01_info.asp"
sw b53n https://www.bgjswc.or.kr "$N"
sw b53h https://www.bgjswc.or.kr "$H"
f b54n "https://www.gijangcmc.or.kr/happycenter/04_community/01_community.asp"
f b55m "https://seongji.or.kr/" ua
