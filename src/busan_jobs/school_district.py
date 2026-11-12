"""학교 공고의 구·군을 나이스 학교 주소로 채운다 ('부산' → '부산 해운대구').

강사잇다 양식의 지역은 '부산 해운대구' 꼴이다(gangsaitda.region). 구청·복지관 공고는 기관명·제목에 구 이름이 있어 채워지지만,
학교 공고는 '포천초등학교'처럼 학교 이름만 있어 '부산'으로 남았다 (2026-11-01: 진행 중 267건 중 학교·유치원 70여 건).

나이스(open.neis.go.kr) 학교기본정보는 인증키 없이 학교 이름 하나를 조회할 수 있다 (경남판에서 러너 접속 확인, 2026-11-01).
부산광역시교육청(C10) 학교 중 이름이 같은 곳의 도로명주소에서 구·군을 읽는다. 결과는 수집 기록 DB 의 school_districts 표에 남겨
같은 학교를 다시 묻지 않는다 (모르면 '' 로 남김). '○○초등학교병설유치원'은 그 초등학교 주소를 쓴다.
따로 있는 유치원은 나이스 학교 목록에 없어 같은 이름의 초등학교 주소를 쓴다 (school_names).
교육청·지원본부 등 부산 전체 기관은 '부산'이 맞다.
"""
from __future__ import annotations

import logging
import re

from .classify import DISTRICTS, infer_district
from .models import Posting

log = logging.getLogger(__name__)

NEIS_URL = "https://open.neis.go.kr/hub/schoolInfo"
NEIS_BUSAN = "C10"  # 부산광역시교육청 시도교육청코드
LOOKUP_MAX = 60  # 한 번 실행에 나이스에 새로 물어볼 학교 수 (나머지는 다음 실행에서)
# 이 날짜 전에 '찾지 못함'으로 남긴 학교는 한 번 더 묻는다 (그때는 같은 이름 학교가 여러 구에 있어도 아무것도 남기지 않았다)
RECHECK_BEFORE = "2026-11-12"
KINDER_TRIES = 4  # 따로 있는 유치원 하나로 물어볼 초등학교 이름 수

_ADDR_RE = re.compile(r"부산(?:광역시)?\s*([가-힣]+(?:구|군))(?![가-힣])")
_ORG_NOISE = re.compile(r"\((?:공립|사립|국립)\)|\s+")
_ANNEX_RE = re.compile(r"([가-힣]{2,10}?)(?:초등학교|초)\s*병설")  # '덕양초병설유', '천가초등학교 병설유치원'
_SCHOOL_RE = re.compile(r"[가-힣]{2,12}(?:초등학교|중학교|고등학교)")  # 제목 속 '연제중학교', '해운대 송정초등학교'


def school_name(org: str) -> str | None:
    """나이스에 물어볼 학교 이름. 학교가 아니면 None ('성남초등학교병설유치원'·'명호초병설유치원' → '…초등학교')."""
    name = _ORG_NOISE.sub("", org or "")
    if name.endswith("병설유치원"):
        name = name.removesuffix("병설유치원")
        if name.endswith("초"):
            name += "등학교"
    return name if name.endswith("학교") and len(name) > 2 else None


def school_names(org: str, title: str = "") -> list[str]:
    """나이스에 물어볼 학교 이름 후보 (앞의 것부터).

    기관명이 잘렸거나('주감초등학교병설유치', '덕양초병설유') 학교 이름이 아니면('박채원') 제목에서 학교 이름을 읽는다.
    따로 있는 유치원은 나이스에 없다. 대개 동네 이름이라 같은 이름의 초등학교 주소를 쓴다
    ('연산유치원' → 연산초등학교, '금샘누리유치원' → … 금샘초등학교). 2026-11-11 진행 중 137건 중 46건이 '부산'뿐이었다.
    """
    out: list[str] = []
    first = school_name(org)
    if first:
        out.append(first)
    out += [m.group(1) + "초등학교" for m in _ANNEX_RE.finditer(f"{org} {title}")]
    out += _SCHOOL_RE.findall(title or "")
    name = _ORG_NOISE.sub("", org or "")
    if name.endswith("유치원") and "병설" not in name:
        stem = name.removesuffix("유치원").removeprefix("부산")
        if 2 <= len(stem) <= 6:
            out += [stem[:k] + "초등학교" for k in range(len(stem), 1, -1)][:KINDER_TRIES]
    return list(dict.fromkeys(out))


def pick_district(found: str, text: str) -> str:
    """저장해 둔 구·군에서 하나를 고른다. 같은 이름 학교가 여러 구에 있으면('강서구,해운대구')
    제목·기관명에 그중 한 구의 이름이 보일 때만 그것을 쓴다 ('해운대 송정초등학교' → 해운대구)."""
    parts = [d for d in (found or "").split(",") if d]
    if len(parts) == 1:
        return parts[0]
    # '해운대구' → '해운대'. '중구'·'서구'처럼 짧은 이름은 한 글자가 아무 데나 들어 있으니 그대로 찾는다
    hits = [d for d in parts if (d[:-1] if len(d) > 2 else d) in (text or "")]
    return hits[0] if len(hits) == 1 else ""


def district_from_address(address: str) -> str | None:
    """'부산광역시 해운대구 좌동순환로 1' → '해운대구'. 부산 구·군이 아니면 None."""
    m = _ADDR_RE.search(address or "")
    return m.group(1) if m and m.group(1) in DISTRICTS else None


def neis_addresses(http, school: str) -> list[str]:
    """나이스에서 부산 학교 중 이름이 같은 곳의 도로명주소들. 접속 실패는 예외로 올린다."""
    resp = http.get(NEIS_URL, params={"Type": "json", "ATPT_OFCDC_SC_CODE": NEIS_BUSAN, "SCHUL_NM": school})
    data = resp.json()
    info = data.get("schoolInfo") or []
    rows = info[1].get("row", []) if len(info) > 1 else []
    return [r.get("ORG_RDNMA", "") for r in rows if r.get("SCHUL_NM") == school]


def fill_districts(postings: list[Posting], store, http) -> int:
    """구·군을 모르는 학교·유치원 공고에 구·군을 채운다 (p.district, 메모리만). 채운 공고 수."""
    filled = lookups = 0
    neis_down = False
    for p in postings:
        text = f"{p.org_name} {p.title}"
        if p.district in DISTRICTS or infer_district(text):
            continue
        for school in school_names(p.org_name, p.title):
            found = store.school_district(school, recheck_before=RECHECK_BEFORE)
            if found is None:
                if neis_down or lookups >= LOOKUP_MAX:
                    break
                lookups += 1
                try:
                    districts = {district_from_address(a) for a in neis_addresses(http, school)}
                except Exception as exc:  # noqa: BLE001 — 나이스가 안 되면 이번 실행에서는 더 묻지 않고 '부산' 그대로
                    log.warning("나이스 학교 주소 조회 실패 (%s): %s", school, exc)
                    neis_down = True
                    break
                # 같은 이름이 여러 구에 있으면 모두 적어 둔다 (pick_district 가 제목으로 고른다). 부산 밖 주소가 섞이면 쓰지 않는다
                found = "" if None in districts else ",".join(sorted(districts))
                store.set_school_district(school, found)
            district = pick_district(found, text)
            if district:
                p.district = district
                filled += 1
                break
    return filled
