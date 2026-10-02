#!/usr/bin/env bash
# (임시) 평생교육원·평생학습관 게시판 조사
f() { python scripts/dev_fetch.py "$@" || true; }

# 다른 저장소에서 확인된 대학 평생교육원
f ysu "https://ysedu.ysu.ac.kr/board/notice_edu/list.asp?gotopage=1"
f pnu_home "https://sce.pusan.ac.kr/"
f pnu_board "https://sce.pusan.ac.kr/page?menuCD=000000000000561"
f deu "https://lifelong.deu.ac.kr/Board/BoardList.aspx?MENU_ID=146&PAGE_NO=&BoardMstNo=1"
f bufs "https://lec.bufs.ac.kr/community_notice?page=1"
f bhu "https://cedu.bhu.ac.kr/Board/BoardList.aspx?MENU_ID=146&PAGE_NO=&BoardMstNo=10"
f silla "https://soc.silla.ac.kr/Home/Sub04/NoticeBoard01.aspx" ua
f dongseo68 "https://uni.dongseo.ac.kr/continuing/index.php?pCode=MN4000068"
f dongseo69 "https://uni.dongseo.ac.kr/continuing/index.php?pCode=MN4000069"
f dongseo75 "https://uni.dongseo.ac.kr/continuing/index.php?pCode=MN4000075"
f tu "https://lifedu.tu.ac.kr/LifelongEdu/Board/ANN001U.aspx?page=1"
f cup "https://edu.cup.ac.kr/organ/edu/front/board/List402.do"
f kit "https://cei.kit.ac.kr/cei/index.php?pCode=MN0000028"
f donga_robots "https://donga-edu.donga.ac.kr/robots.txt"
f donga "https://donga-edu.donga.ac.kr/community_notice/list.aspx?board_code=NOTICE&page=1"
f pknu_ps "https://ps.pknu.ac.kr/"
f pknu163 "https://www.pknu.ac.kr/main/163"
f dit "https://ce.dit.ac.kr/dit/index.php?pCode=MN0000014"
f ks "https://cms.ks.ac.kr/kscec/main.do"

# 새 후보
f kosin "https://kosinedu.com/index.php?mid=sub04_1"
f kosin_home "https://kosinedu.com/"
f bwc "https://sahoi.bwc.ac.kr/04_board/?mcode=0404010000"
f bist "http://life.bist.ac.kr/sub/?mcode=0405010000"
f bit "http://life.bit.ac.kr/sub/?mcode=0405010000"
f kmou_home "https://www.kmou.ac.kr/edu/main.do"
f daedong_home "https://lifeedu.daedong.ac.kr/"
f bdu_home "http://www.bdu.ac.kr/edulife/index.do"
f dongju_home "https://www.dongju.ac.kr/"
f bnue_home "https://www.bnue.ac.kr/"
f lll_busan "https://lll.busan.go.kr/lll/index.do"

# 구 평생학습관 (빠진 곳)
f busanjin_lll "https://www.busanjin.go.kr/lll/index.busanjin"
f dongnae_lll "https://www.dongnae.go.kr/lll/index.dongnae"
f yeongdo_hll "https://www.yeongdo.go.kr/hll/01419/01420.web?gcode=1146"
f yeongdo_home "https://www.yeongdo.go.kr/hll.web"
