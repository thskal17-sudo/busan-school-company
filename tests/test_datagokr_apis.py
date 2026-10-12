"""공공데이터포털 Open API 수집기: 나라일터(인사혁신처)·잡알리오(재정경제부).

fixtures/mpm_list.xml·alio_list.json 은 2026-10-12 수집 서버에서 받은 실제 응답에서 몇 건만 남긴 것.
"""
from datetime import date

import pytest
import requests

from busan_jobs.collectors.alio_api import AlioJobCollector, parse_alio_json
from busan_jobs.collectors.base import NotConfigured
from busan_jobs.collectors.datagokr import ymd
from busan_jobs.collectors.mpm_api import MpmJobCollector, in_area, parse_mpm_xml
from busan_jobs.config import load_settings

TODAY = date(2026, 10, 12)
SOURCES = {s.id: s for s in load_settings().sources}


class _Resp:
    def __init__(self, content: bytes):
        self.content = content


class _Http:
    def __init__(self, *pages: bytes):
        self.pages = list(pages)
        self.calls: list[tuple[str, dict]] = []

    def get(self, url, params=None, **kw):
        self.calls.append((url, params))
        return _Resp(self.pages[min(len(self.calls), len(self.pages)) - 1])


def test_ymd():
    assert ymd("20261018") == date(2026, 10, 18)
    assert ymd(" ") is None and ymd("19000101") is None and ymd("20261340") is None and ymd(None) is None


def test_mpm_parse_and_busan_filter(fixture_bytes):
    items, total = parse_mpm_xml(fixture_bytes("mpm_list.xml"))
    assert total == 6 and len(items) == 6
    busan = [i["idx"] for i in items if in_area(i)]
    # 26… 지역코드, 여러 지역 중 부산 포함, 00000 이면서 기관명에 부산 → 부산.
    # 부산지방우정청 하동우체국(48850 경남)·서울 학교는 뺀다
    assert busan == ["305163", "303075", "305417", "304579"]


def test_mpm_collect(fixture_bytes, monkeypatch):
    monkeypatch.setenv("DATA_GO_KR_KEY", "abc%2Bdef")
    http = _Http(fixture_bytes("mpm_list.xml"))
    posts = MpmJobCollector(SOURCES["gojobs_list"], http, TODAY).collect()
    url, params = http.calls[0]
    assert url.endswith("/1760000/PblJobService/getList") and len(http.calls) == 1  # 6건 < 100건이라 한 쪽
    assert params["serviceKey"] == "abc+def"  # Encoding 키는 풀어서 보낸다
    assert params["Begin_de"] == "2026-09-28" and params["End_de"] == "2026-10-12"  # 최근 14일
    assert params["Pblanc_ty"] == "" and params["Instt_se"] == ""
    p = posts[0]
    assert p.title == "2026학년도 부암초등학교 특수(초등) 시간강사 채용 공고"
    # 게시판을 읽던 때와 같은 글번호·주소라 이미 저장한 공고와 이어진다
    assert p.post_key == "305163"
    assert p.url == p.detail_url == "https://www.gojobs.go.kr/apmView.do?empmnsn=305163&searchJobsecode=020&menuNo=401&selMenuNo=400"
    assert p.district == "부산진구" and p.org_type == "교육청·학교"
    assert p.posted_date == date(2026, 10, 7) and p.deadline == date(2026, 10, 13)
    assert posts[1].district == "해운대구"
    assert posts[2].district == "영도구"  # 26200,51000 → 부산 쪽 코드만 본다
    assert posts[3].district == "부산전체"  # 00000


def test_mpm_pages_until_total(fixture_bytes, monkeypatch):
    monkeypatch.setenv("DATA_GO_KR_KEY", "k")
    xml = fixture_bytes("mpm_list.xml").replace(b"<totalCount>6</totalCount>", b"<totalCount>250</totalCount>")
    http = _Http(xml, xml, xml, xml)
    MpmJobCollector(SOURCES["gojobs_list"], http, TODAY).collect()
    assert [c[1]["pageNo"] for c in http.calls] == [1, 2, 3]


def test_mpm_api_error(fixture_bytes):
    with pytest.raises(RuntimeError, match="30 SERVICE_KEY_IS_NOT_REGISTERED_ERROR"):
        parse_mpm_xml(fixture_bytes("datagokr_key_error.xml"))


def test_alio_collect(fixture_bytes, monkeypatch):
    monkeypatch.setenv("DATA_GO_KR_KEY", "k")
    http = _Http(fixture_bytes("alio_list.json"))
    posts = AlioJobCollector(SOURCES["alio_recruit"], http, TODAY).collect()
    url, params = http.calls[0]
    assert url.endswith("/1051000/recruitment/list")
    assert params["workRgnLst"] == "R3014" and params["ongoingYn"] == "Y" and params["resultType"] == "json"
    assert [p.post_key for p in posts] == ["305916", "305902", "305830"]
    p = posts[1]
    assert p.title == "제2026-6호 한국청소년상담복지개발원 직원 모집"
    assert p.url == p.detail_url == "https://job.alio.go.kr/recruitview.do?idx=305902"
    assert p.org_name == "한국청소년상담복지개발원"
    assert p.posted_date == date(2026, 10, 12) and p.deadline == date(2026, 10, 27)


def test_alio_errors():
    with pytest.raises(RuntimeError, match="잡알리오 API 오류: 500"):
        parse_alio_json(b'{"resultCode":500,"resultMsg":"fail"}')
    with pytest.raises(RuntimeError, match="SERVICE_KEY_IS_NOT_REGISTERED"):  # 포털 게이트웨이 오류는 XML
        parse_alio_json(b"<OpenAPI_ServiceResponse><cmmMsgHeader><returnAuthMsg>SERVICE_KEY_IS_NOT_REGISTERED_ERROR</returnAuthMsg></cmmMsgHeader></OpenAPI_ServiceResponse>")


@pytest.mark.parametrize("cls,sid", [(MpmJobCollector, "gojobs_list"), (AlioJobCollector, "alio_recruit")])
def test_missing_key_and_hidden_key(cls, sid, monkeypatch):
    monkeypatch.delenv("DATA_GO_KR_KEY", raising=False)
    with pytest.raises(NotConfigured):
        cls(SOURCES[sid], _Http(b""), TODAY).collect()

    monkeypatch.setenv("DATA_GO_KR_KEY", "SECRET+KEY/123")

    class _Boom:
        def get(self, url, params=None, **kw):
            raise requests.exceptions.HTTPError(
                "403 Client Error for url: https://apis.data.go.kr/x?serviceKey=SECRET%2BKEY%2F123&pageNo=1")

    with pytest.raises(requests.exceptions.HTTPError) as info:
        cls(SOURCES[sid], _Boom(), TODAY).collect()
    assert "SECRET" not in str(info.value) and "serviceKey=***" in str(info.value)
