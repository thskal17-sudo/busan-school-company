#!/usr/bin/env bash
# (임시) 도서관 2차: 도서관포털 '부산공공도서관' 목록 전체
f() { python scripts/dev_fetch.py "$@" || true; }
for p in 1 2 3 4 5 6; do
  f "pub_$p" "https://library.busan.go.kr/portal/module/libraryInfo/index.do?menu_idx=73&lib_cate_code=0001&viewPage=$p"
done
