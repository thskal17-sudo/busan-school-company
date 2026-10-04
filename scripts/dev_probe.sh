#!/usr/bin/env bash
# (임시) 육아종합지원센터 게시판 조사 3차: 제목 '강사' 검색 (POST, 사이트 문자셋에 맞춤)
python - <<'PY'
import sys
from pathlib import Path
sys.path.insert(0, "src")
from busan_jobs.http import Http
from busan_jobs.collectors.board import parse_board
from busan_jobs.models import today_kst
http = Http(min_interval=0.5, retries=0, max_seconds=40)
out = Path("probe_out"); out.mkdir(exist_ok=True)
H = {"Content-Type": "application/x-www-form-urlencoded"}
K8, KE = "%EA%B0%95%EC%82%AC", "%B0%AD%BB%E7"  # 강사 (UTF-8 / EUC-KR)
jobs = [
    ("cc_notice_s", "https://busan.childcare.go.kr/ccef/community/notice/NoticeSlPL.jsp", f"flag=&BBSGB=47&choice=SCHBTITLE&SCHBTITLE={K8}"),
    ("cc_hire_s", "https://busan.childcare.go.kr/ccef/community/notice/NoticeSlPL.jsp", f"flag=&BBSGB=1233&choice=SCHBTITLE&SCHBTITLE={K8}"),
    ("ns_sasang", "https://www.sasangicare.kr/board/list.asp", f"BoardID=0001&Cate=&search=title&SearchString={KE}"),
    ("ns_bjscfc", "https://www.bjscfc.or.kr/board/list.asp", f"BoardID=0001&Cate=&search=title&SearchString={KE}"),
    ("ns_gijang", "https://gijangchild.or.kr/board/list.asp", f"BoardID=0001&Cate=&search=title&SearchString={KE}"),
    ("ns_bsyscc", "https://www.bsyscc.or.kr/new/board/list.asp", f"BoardID=0001&Cate=&search=title&SearchString={KE}"),
    ("ns_bsscc", "https://www.bsscc.or.kr/community/board_list.asp", f"BoardID=0003&Cate=&search=title&SearchString={K8}"),
    ("ns_gjscc", "https://www.gjscc.or.kr/community/board_list.asp", f"BoardID=0004&Cate=&search=title&SearchString={K8}"),
    ("ns_sahascc", "https://www.sahascc.or.kr/community/board_list.asp", f"BoardID=0004&Cate=&search=title&SearchString={K8}"),
    ("ns_ydgscc", "https://www.ydgscc.or.kr/community/board_list.asp", f"BoardID=0003&Cate=&search=title&SearchString={K8}"),
]
for name, url, body in jobs:
    try:
        resp = http.session.post(url, data=body.encode("ascii"), headers=H, timeout=30)
    except Exception as exc:
        print(f"[{name}] ERROR {type(exc).__name__}: {str(exc)[:200]}"); continue
    (out / f"{name}.html").write_bytes(resp.content)
    rows = parse_board(resp.content, resp.url, {}, today_kst())
    print(f"[{name}] {resp.status_code} {len(resp.content)}B rows={len(rows)}")
    for r in rows[:12]:
        print(f"    · {r.posted} {r.title[:70]!r}")
PY
