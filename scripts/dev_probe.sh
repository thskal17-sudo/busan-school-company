#!/usr/bin/env bash
# (임시) 다문화가족지원센터(가족센터) 게시판 조사 4차: 다누리 포털 채용정보 (전국 가족센터 채용 모음)
f() { python scripts/dev_fetch.py "$@" || true; }
W=https://www.liveinkorea.kr/web/lay1/bbs/S1T10C29/A/6
K=%EA%B0%95%EC%82%AC  # 강사
f dp_all "$W/list.do"
f dp_bs "$W/list.do?area=A002"
f dp_bs_kw "$W/list.do?area=A002&condition=TITLE&keyword=$K"
f dp_bs_p2 "$W/list.do?area=A002&cpage=2&rows=10"
f dp_view "$W/view.do?article_seq=169574"
f dp_centers "https://www.liveinkorea.kr/web/lay1/program/S1T118C119/centerIntro/centerList.do"
