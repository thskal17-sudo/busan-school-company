"""학교 공고의 구·군 채우기 (school_district.py): 나이스 학교 주소, DB 에 남기기, 강사잇다 지역 칸."""
from datetime import date

from busan_jobs import school_district
from busan_jobs.gangsaitda import region
from busan_jobs.models import Posting
from busan_jobs.school_district import district_from_address, fill_districts, school_name
from busan_jobs.storage import Store

ADDR = {
    "포천초등학교": ["부산광역시 남구 우암로 1"],
    "두송중학교": ["부산광역시 사하구 다대로 2"],
    "성남초등학교": ["부산광역시 동구 x"],
    "같은이름초등학교": ["부산광역시 북구 a", "부산광역시 강서구 b"],  # 두 구에 있으면 쓰지 않는다
}


def _post(org: str, title: str = "방과후 강사 모집", district: str = "") -> Posting:
    return Posting("pen_school_hire", title, f"https://x.org/{org}", org, org, org_type="교육청·학교",
                   district=district, deadline=date(2026, 11, 20))


def test_names_and_addresses():
    assert school_name("포천초등학교") == "포천초등학교"
    assert school_name("성남초등학교병설유치원") == "성남초등학교"
    assert school_name("명호초병설유치원") == "명호초등학교"
    assert school_name("지산유치원(공립)") is None and school_name("부산광역시교육청") is None
    assert school_name("부산학교행정지원본부") is None
    assert district_from_address("부산광역시 해운대구 좌동순환로 1") == "해운대구"
    assert district_from_address("부산광역시 기장군 기장읍") == "기장군"
    assert district_from_address("경상남도 김해시") is None


def test_fills_from_neis_and_remembers(tmp_path, monkeypatch):
    calls = []

    def fake(http, school):
        calls.append(school)
        return ADDR.get(school, [])

    monkeypatch.setattr(school_district, "neis_addresses", fake)
    store = Store(tmp_path / "db.sqlite")
    pocheon, dusong, kinder, twin, office, known, titled = (
        _post("포천초등학교"), _post("두송중학교"), _post("성남초등학교병설유치원"), _post("같은이름초등학교"),
        _post("부산광역시교육청"), _post("명지초등학교", district="강서구"), _post("어딘가초등학교", title="해운대구 늘봄 강사"),
    )
    n = fill_districts([pocheon, dusong, kinder, twin, office, known, titled], store, http=None)
    assert n == 3
    assert region(pocheon) == "부산 남구" and region(dusong) == "부산 사하구" and region(kinder) == "부산 동구"
    assert region(twin) == "부산" and region(office) == "부산"
    assert region(known) == "부산 강서구" and region(titled) == "부산 해운대구"  # 이미 아는 구는 묻지 않는다
    assert calls == ["포천초등학교", "두송중학교", "성남초등학교", "같은이름초등학교"]
    store.commit()

    # 다음 실행: DB 에 남아 있어 다시 묻지 않는다 (찾지 못한 학교도)
    calls.clear()
    again = Store(tmp_path / "db.sqlite")
    p, q = _post("포천초등학교"), _post("같은이름초등학교")
    fill_districts([p, q], again, http=None)
    assert region(p) == "부산 남구" and region(q) == "부산" and calls == []


def test_neis_down_stops_asking_and_remembers_nothing(tmp_path, monkeypatch):
    calls = []

    def down(http, school):
        calls.append(school)
        raise ConnectionError("down")

    monkeypatch.setattr(school_district, "neis_addresses", down)
    store = Store(tmp_path / "db.sqlite")
    posts = [_post("포천초등학교"), _post("두송중학교")]
    assert fill_districts(posts, store, http=None) == 0
    assert calls == ["포천초등학교"]  # 한 번 실패하면 이번 실행에서는 더 묻지 않는다
    assert store.school_district("포천초등학교") is None  # 다음 실행에서 다시 묻는다


def test_neis_addresses_reads_api_shape(monkeypatch):
    class Resp:
        def json(self):
            return {"schoolInfo": [{"head": [{"list_total_count": 2}]}, {"row": [
                {"SCHUL_NM": "포천초등학교", "ORG_RDNMA": "부산광역시 남구 우암로 1"},
                {"SCHUL_NM": "포천초등학교분교", "ORG_RDNMA": "부산광역시 북구 x"},  # 이름이 다르면 뺀다
            ]}]}

    class Http:
        def get(self, url, params=None, **kw):
            assert params["ATPT_OFCDC_SC_CODE"] == "C10" and params["SCHUL_NM"] == "포천초등학교"
            return Resp()

    monkeypatch.undo()  # conftest 의 가짜를 걷어 내고 원래 함수로
    assert school_district.neis_addresses(Http(), "포천초등학교") == ["부산광역시 남구 우암로 1"]
