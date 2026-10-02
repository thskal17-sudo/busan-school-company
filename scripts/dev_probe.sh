#!/usr/bin/env bash
# (임시) 종합사회복지관 2차: 사회복지관 목록
f() { python scripts/dev_fetch.py "$@" || true; }
f city_welpolicy "https://www.busan.go.kr/depart/welpolicy0103"
f baswc_list_ua "https://www.baswc.org/guide/sub2.php" ua
curl -s -m 20 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0 Safari/537.36" -e "https://www.baswc.org/" -o probe_out/baswc_list_curl.html -w "baswc curl %{http_code} %{size_download} %{url_effective} %{redirect_url}\n" "https://www.baswc.org/guide/sub2.php" || true
f kaswc_busan "https://kaswc.or.kr/member?area=%EB%B6%80%EC%82%B0"
f kaswc_main "https://kaswc.or.kr/"
