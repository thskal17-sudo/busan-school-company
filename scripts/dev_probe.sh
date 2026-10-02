#!/usr/bin/env bash
# (임시) 종합사회복지관 8차: 새 게시판 시험 수집
f() { python scripts/dev_fetch.py "$@" || true; }
python -m busan_jobs check-source cw_gangseo_notice cw_gangseo_hire cw_nakdong_notice cw_geumjeong_notice cw_namgwang_notice cw_gamman_notice cw_yongho_notice cw_chorogusan_notice cw_sajik_notice cw_busanjin_notice cw_gaegeum_notice cw_danggam_notice cw_danggam_hire cw_jeonpo_notice cw_jangseon_notice cw_jangseon_hire cw_deokcheon_notice cw_gongchang_notice cw_dongwon_notice cw_namsanjeong_notice cw_hwamyeong_notice cw_hwamyeong_hire cw_mandeok_notice cw_mandeok_hire cw_mora_notice cw_sasang_notice cw_hakjang_notice cw_hakjang_hire cw_saha_notice cw_gupyung_notice cw_seogu_notice cw_holtsy_notice cw_holtsy_hire cw_yeongdo_notice cw_yeongdo_hire cw_dongsam_notice cw_jeolyeong_notice cw_sangli_notice cw_wachi_notice cw_junggu_notice cw_yeongjin_notice cw_yeongjin_hire cw_haeundae_notice cw_unbong_notice cw_unbong_hire cw_banseok_notice cw_parangsae_notice cw_parangsae_hire cw_banyeo_notice cw_gijang_notice cw_dahaengbok_notice cw_geoje_notice cw_geoje_hire  > probe_out/check.txt 2>&1
grep -E "^===|목록 |오류|\[ (신규|모집중|진행중|결과공고) \]" probe_out/check.txt
f e19n "http://hwajung.saem.or.kr/community/news1.php" ua
f e19m "http://hwajung.saem.or.kr/community/news.php" ua
f e46g "http://haeundae.saem.or.kr/community/news2.php"
