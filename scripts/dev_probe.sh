#!/usr/bin/env bash
# (임시) 청소년상담복지센터 1차: 센터 목록·홈페이지 첫 화면
f() { python scripts/dev_fetch.py "$@" || true; }
f cando_main "http://www.cando.or.kr/"
f cando_net "http://www.cando.or.kr/bbs/board.php?bo_table=busan_network"
f cando_net2 "http://www.cando.or.kr/bbs/board.php?bo_table=busan_network&page=2"
f city_children "https://www.busan.go.kr/depart/children0408"
f kyci_list "https://www.kyci.or.kr/userSite/cooperation/list.asp?basicNum=1"
f bsjin "https://www.bsjin1388.or.kr/"
f haeundae "http://u-dream.or.kr/"
f bukgu_notice "https://www.bsbukgu.go.kr/youth/board/list.bsbukgu?boardId=BBS_0000066&menuCd=DOM_000000904004000000&paging=ok&startPage=1"
f bukgu_main "https://www.bsbukgu.go.kr/youth/index.bsbukgu"
f junggu "https://www.bsjunggu.go.kr/welfare/index.junggu?menuCd=DOM_000000404008000000"
