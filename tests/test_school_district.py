"""학교 공고의 구·군 채우기 (school_district.py): 나이스 학교 주소, DB 에 남기기, 강사잇다 지역 칸."""
from datetime import date

from busan_jobs import school_district
from busan_jobs.gangsaitda import region
from busan_jobs.models import Posting
from busan_jobs.school_district import district_from_address, fill_districts, pick_district, school_name, school_names
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


def test_more_names_from_title_and_kindergartens():
    assert school_names("주감초등학교병설유치", "주감초등학교병설유치원 겨울방학 중 방과후과정") == ["주감초등학교"]
    assert school_names("덕양초병설유", "덕양초등학교병설유치원 겨울방학") == ["덕양초등학교"]
    assert school_names("대천리병설유치원", "2026학년도 대천리초등학교병설유치원 겨울방학") == ["대천리초등학교"]
    assert school_names("박채원", "연제중학교 사회과 시간강사채용 재공고") == ["연제중학교"]  # 기관명이 사람 이름
    assert school_names("연산유치원(공립)", "연산유치원 방과후과정") == ["연산초등학교"]
    assert school_names("금샘누리유치원") == ["금샘누리초등학교", "금샘누초등학교", "금샘초등학교"]
    assert school_names("부산광역시교육청", "학교운동부지도자 모집") == []


def test_same_name_in_two_districts_uses_title():
    assert pick_district("강서구,해운대구", "송정초등학교 2026학년도 해운대 송정초등학교 특수학급") == "해운대구"
    assert pick_district("강서구,해운대구", "송정초등학교 특수학급 시간강사") == ""
    assert pick_district("서구,중구", "서부 중앙 학교") == ""  # 짧은 구 이름은 한 글자로 고르지 않는다
    assert pick_district("남구", "아무거나") == "남구" and pick_district("", "x") == ""


def test_fills_kindergarten_truncated_and_twin(tmp_path, monkeypatch):
    addr = {
        "연산초등학교": ["부산광역시 연제구 a"],
        "금샘초등학교": ["부산광역시 금정구 b"],
        "주감초등학교": ["부산광역시 강서구 c"],
        "송정초등학교": ["부산광역시 해운대구 d", "부산광역시 강서구 e"],
    }
    calls = []

    def fake(http, school):
        calls.append(school)
        return addr.get(school, [])

    monkeypatch.setattr(school_district, "neis_addresses", fake)
    store = Store(tmp_path / "db.sqlite")
    # 예전에 '찾지 못함'으로 남긴 송정초는 다시 묻는다
    store.conn.execute("INSERT INTO school_districts VALUES ('송정초등학교', '', '2026-11-05T06:00:00')")
    yeonsan, geumsaem, jugam, songjeong, dongil = (
        _post("연산유치원"), _post("금샘누리유치원"), _post("주감초등학교병설유치", "주감초등학교병설유치원 방과후"),
        _post("송정초등학교", "2026학년도 해운대 송정초등학교 특수학급 시간강사"), _post("동일유치원"),
    )
    assert fill_districts([yeonsan, geumsaem, jugam, songjeong, dongil], store, http=None) == 4
    assert region(yeonsan) == "부산 연제구" and region(geumsaem) == "부산 금정구" and region(jugam) == "부산 강서구"
    assert region(songjeong) == "부산 해운대구" and region(dongil) == "부산"  # 같은 이름 초등학교가 없으면 '부산' 그대로
    assert store.school_district("송정초등학교") == "강서구,해운대구"
    # 이름이 같아도 제목에 구 이름이 없으면 고르지 않는다
    other = _post("송정초등학교", "송정초등학교 시간강사")
    assert fill_districts([other], store, http=None) == 0 and region(other) == "부산"
