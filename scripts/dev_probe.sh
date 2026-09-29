#!/usr/bin/env bash
# (임시) 여성인력개발센터: 동구·사하 게시판, 해운대 글 주소가 요청마다 같은지
f() { python scripts/dev_fetch.py "$@" || true; }
f dg_notice "http://www.ewoman.or.kr/p/?j=41"
f dg_jobs "http://www.ewoman.or.kr/p/?j=75"
f saha_home "http://www.sahawcenter.or.kr/"
f saha_home_s "https://www.sahawcenter.or.kr/"
f hw_a "https://www.hwcenter.or.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
sleep 20
f hw_b "https://www.hwcenter.or.kr/SW_bbs/notice/list.php?zipEncode==u2yPr3BU91vt1drjrMCH9MyMetpSfMvWLME"
python - <<'PY'
import re
a = re.findall(r'notice/view\.php\?zipEncode=[^"]+', open("probe_out/hw_a.html", encoding="utf-8", errors="replace").read())
b = re.findall(r'notice/view\.php\?zipEncode=[^"]+', open("probe_out/hw_b.html", encoding="utf-8", errors="replace").read())
print("hw same links:", a == b, len(a), len(b))
PY
python -m busan_jobs check-source bswoman_notice dongnae_woman_notice hwcenter_notice 2>&1 | grep -E "^===|목록|오류"
