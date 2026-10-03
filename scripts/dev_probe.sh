#!/usr/bin/env bash
# (임시) 부산진구생활문화센터 공지
f() { python scripts/dev_fetch.py "$@" || true; }
f bjlife_notice "http://busanjinlifeculture.quv.kr/11"
f bjlife_news "http://busanjinlifeculture.quv.kr/news"
