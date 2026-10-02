#!/usr/bin/env bash
# (임시) 평생교육원 게시판 시험 수집 4차
python -m busan_jobs check-source univ_kmou_notice univ_bist_notice univ_pnu_sce univ_bufs_notice > probe_out/check.txt 2>&1 || true
