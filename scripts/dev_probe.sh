#!/usr/bin/env bash
# (임시) 평생교육원·평생학습관 게시판 조사 2차
f() { python scripts/dev_fetch.py "$@" || true; }

f kosin_0342 "https://kosinedu.com/sub03_4_2"
f kosin_0502 "https://kosinedu.com/sub05_2"
f kosin_0601 "https://kosinedu.com/sub06_1"
f kosin_0602 "https://kosinedu.com/sub06_2"
f kmou "https://www.kmou.ac.kr/edu/na/ntt/selectNttList.do?mi=426&bbsId=10304"
f daedong "http://lifeedu.daedong.ac.kr/lifeedu/CMS/Board/Board.do?mCode=MN046"
f bdu "https://www.bdu.ac.kr/edulife/sub07_01_01.do"
f bnue_life "https://lifelong.bnue.ac.kr"
f dongju_home "http://dongju.ac.kr/default/main/main_image.jsp"
f bsks_home "https://www.bsks.ac.kr/"
f busanjin_notice "https://www.busanjin.go.kr/board/list.busanjin?boardId=BBS_0000010&menuCd=DOM_000000206001000000"
f busanjin_edusa "https://www.busanjin.go.kr/lll/index.busanjin?menuCd=DOM_000000205001003000"
f dongnae_notice "https://www.dongnae.go.kr/board/list.dongnae?boardId=BBS_0000087&menuCd=DOM_000000709001000000"
f yeongdo_news "https://www.yeongdo.go.kr/hll/01419/01421.web"
f lll_notice "https://lll.busan.go.kr/lll/index.do?menu_id=00003220"
f lll_org "https://lll.busan.go.kr/lll/index.do?menu_id=00004673"
f lll_lect "https://lll.busan.go.kr/lll/index.do?menu_id=00003810"

for h in ysedu.ysu.ac.kr sce.pusan.ac.kr lifelong.deu.ac.kr lec.bufs.ac.kr cedu.bhu.ac.kr soc.silla.ac.kr \
         uni.dongseo.ac.kr lifedu.tu.ac.kr edu.cup.ac.kr cei.kit.ac.kr www.pknu.ac.kr kosinedu.com sahoi.bwc.ac.kr \
         www.kmou.ac.kr lifeedu.daedong.ac.kr www.bdu.ac.kr lifelong.bnue.ac.kr lll.busan.go.kr; do
  echo "--- robots $h"
  curl -s -m 15 -A "Mozilla/5.0" "https://$h/robots.txt" | head -c 600 | grep -v "^\s*$" | head -20
  echo
done
curl -s -m 15 "http://life.bist.ac.kr/robots.txt" | head -c 400; echo
