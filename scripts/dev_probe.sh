#!/usr/bin/env bash
# (임시) 평생교육원·평생학습관 게시판 시험 수집 3차
f() { python scripts/dev_fetch.py "$@" || true; }

f kmou_cp "https://www.kmou.ac.kr/edu/na/ntt/selectNttList.do?mi=426&bbsId=10304&currPage=1"
f kmou_post "https://www.kmou.ac.kr/edu/na/ntt/selectNttList.do" "post:mi=426&bbsId=10304&currPage=1"
f kmou_ua "https://www.kmou.ac.kr/edu/na/ntt/selectNttList.do?mi=426&bbsId=10304" ua
f kmou_view "https://www.kmou.ac.kr/edu/na/ntt/selectNttInfo.do?nttSn=10379593&mi=426"
f bist_https "https://life.bist.ac.kr/sub/?mcode=0405010000"
f lll_view "https://lll.busan.go.kr/lll/index.do?menu_id=00003220&menu_link=/icms/bbs/selectBoardArticle.do&bbsId=BBS_00029&nttId=6271&bbsTyCode=BBST03&bbsAttrbCode=BBSA03"
f cup_view "https://edu.cup.ac.kr/organ/edu/front/board/List402.do?seq=374"

python -m busan_jobs check-source busanjin_lifelong dongnae_lifelong yeongdo_lifelong lll_busan_notice lll_busan_org \
  univ_pnu_sce univ_deu_notice univ_bufs_notice univ_bhu_notice univ_silla_notice univ_dongseo_notice univ_dongseo_50plus \
  univ_tu_notice univ_cup_notice univ_kit_notice univ_ysu_notice univ_kosin_notice univ_kosin_credit univ_bwc_notice \
  univ_bist_notice univ_daedong_notice univ_bdu_notice > probe_out/check.txt 2>&1 || true
