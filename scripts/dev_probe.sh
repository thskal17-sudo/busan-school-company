#!/usr/bin/env bash
# (임시) 복지관 9차: 북구장애인·실버벨·연제 다시
IDS="bgrc_hire senior_silverbell_hire senior_yeonje_notice"
python -m busan_jobs check-source $IDS 2>&1 | tee probe_out/_check.txt | grep -E "^===|목록|오류"
