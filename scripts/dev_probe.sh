#!/usr/bin/env bash
# (임시) 학생교육문화회관 누리집
f() { python scripts/dev_fetch.py "$@" || true; }
f becs_home "https://home.pen.go.kr/becs/main.do"
