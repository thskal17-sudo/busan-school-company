#!/usr/bin/env bash
# (임시) 문화센터 1차: 구 문화원·문화회관 첫 화면
f() { python scripts/dev_fetch.py "$@" || true; }
f cc_junggu "https://www.bsjunggucc.com/"
f cc_seogu "https://www.seogucc.or.kr/"
f cc_donggu "http://bdgcc.or.kr/"
f cc_busanjin "http://busanjin.kccf.or.kr/"
f cc_namgu "http://www.bsnamgucc.or.kr/"
f cc_haeundae "http://www.hudcc.or.kr/"
f cc_geumjeong "http://kumjung.or.kr/main.php"
f cc_gangseo "http://www.bsgangseo.com/"
f cc_yeonje "https://www.bsyjculture.or.kr/"
for k in yeongdo dongnae saha suyeong sasang gijang nakdong bsbukgu bukgu; do f "cc_k_$k" "http://$k.kccf.or.kr/"; done
f dabom "https://www.busandabom.net/index.nm?menuCd=189"
f hall_bscc "https://www.bscc.or.kr/05_community/?mcode=0405010000"
f hall_geumjeong "https://art.geumjeong.go.kr/"
f hall_dongnae "https://www.dongnae.go.kr/culture/index.dongnae"
f hall_gjfac "https://www.gjfac.org/"
