from datetime import date, datetime

from busan_jobs.models import KST, Posting
from busan_jobs.storage import DUPLICATE, Store, title_key

NOW = datetime(2026, 9, 29, 6, 37, tzinfo=KST)


def _p(source, key, title, district="부산전체", posted=date(2026, 9, 29), org=""):
    return Posting(source, title, f"https://example.org/{source}/{key}", key, org, district=district, posted_date=posted)


def test_title_key_ignores_spacing_and_marks():
    assert title_key("[우암초등학교 공고 제2026-27호] 특수학급 시간강사") == title_key("[우암초등학교 공고 제2026 27호]특수학급 시간강사")


def test_same_posting_on_two_boards_is_new_once(tmp_path):
    # 부산교육청 학교인력채용에 올라온 공고가 북부교육지원청 게시판에도 올라온다
    store = Store(tmp_path / "db.sqlite")
    main = _p("pen_school_hire", "1180893", "2026학년도 가람중학교 문화예술교육 강사 채용 공고", org="가람중학교")
    mirror = _p("bukbu_edu_hire", "1039718", "2026학년도 가람중학교 문화예술교육 강사 채용 공고", org="가람중학교")
    assert store.upsert(main, NOW) is True
    assert store.upsert(mirror, NOW) is False
    statuses = {p.source_id: p.status for p in store.unreported()}
    assert statuses == {"pen_school_hire": "모집중", "bukbu_edu_hire": DUPLICATE}
    assert [p.source_id for p in store.active(NOW.date(), 30)] == ["pen_school_hire"]

    # 다음 날 목록에 그대로 있어도 '중복'이 '모집중'으로 돌아가지 않는다
    store.upsert(_p("bukbu_edu_hire", "1039718", "2026학년도 가람중학교 문화예술교육 강사 채용 공고"), NOW)
    assert {p.source_id: p.status for p in store.unreported()}["bukbu_edu_hire"] == DUPLICATE
    store.close()


def test_different_postings_are_not_merged(tmp_path):
    store = Store(tmp_path / "db.sqlite")
    # 같은 제목이라도 다른 구의 공단 공고, 짧은 제목, 게시일이 멀리 떨어진 공고는 따로 본다
    assert store.upsert(_p("bnfmc_hire", "297", "2026년 제4회 시간강사 채용공고 (수영)", "남구"), NOW)
    assert store.upsert(_p("gijangcmc_hire", "1700", "2026년 제4회 시간강사 채용공고 (수영)", "기장군"), NOW)
    assert store.upsert(_p("a", "1", "시간강사 채용 공고"), NOW)
    assert store.upsert(_p("b", "1", "시간강사 채용 공고"), NOW)
    assert store.upsert(_p("c", "1", "2026년 해운대구 건강생활지원센터 건강지도자 위촉 공고", "해운대구",
                           posted=date(2026, 6, 1)), NOW)
    assert store.upsert(_p("d", "1", "2026년 해운대구 건강생활지원센터 건강지도자 위촉 공고", "해운대구"), NOW)
    assert all(p.status == "모집중" for p in store.unreported())
    store.close()


def test_fix_deadlines_by_url(tmp_path):
    # 마감일이 첨부 공고문에만 있어 비어 있던 공고를 config/deadlines.yaml 의 값으로 고친다
    from busan_jobs.config import load_deadline_fixes

    store = Store(tmp_path / "db.sqlite")
    p = _p("pen_school_hire", "1181764", "부산해마루학교 2027학년도 방과후학교 강사 채용 공고", org="부산해마루학교")
    store.upsert(p, NOW)
    assert store.fix_deadlines({"https://example.org/other/1": date(2026, 10, 19)}) == 0  # 없는 공고는 건너뜀
    assert store.fix_deadlines({p.url: date(2026, 10, 19)}) == 1
    assert store.detail_state(p.uid)[0] == date(2026, 10, 19)
    assert store.fix_deadlines({p.url: date(2026, 10, 19)}) == 0  # 이미 같으면 그대로
    store.close()

    fixes = load_deadline_fixes()
    url = "https://www.pen.go.kr/main/na/ntt/selectNttInfo.do?mi=30367&bbsId=2364&nttSn=1181764"
    assert fixes[url] == date(2026, 10, 19)


def test_expiring_board_uses_lasting_twin_link(tmp_path):
    """부산시청 통합 채용정보는 마감 뒤 글을 내린다. 같은 공고가 여성회관 공지에도 있으면 그 주소를 원문 링크로 쓴다 (2026-11-05)."""
    from busan_jobs.config import Source
    from busan_jobs.pipeline import prefer_lasting_links

    store = Store(tmp_path / "db.sqlite")
    title = "2027년 상반기 여성회관 교육강사 모집 공고"
    city = Posting("city_jobs", title, "https://www.busan.go.kr/depart/jobgonji01/1759885", "1759885", "부산광역시 교육복지팀",
                   district="부산전체", posted_date=date(2026, 10, 20))
    hall = Posting("womenhall_notice", title, "https://www.busan.go.kr/woman/whnotice/1759884", "1759884", "교육복지팀",
                   district="부산전체", posted_date=date(2026, 10, 20))
    other = _p("pen_school_hire", "1", "2026학년도 가람중학교 문화예술교육 강사 채용 공고")
    store.upsert(city, NOW)
    store.upsert(hall, NOW)  # 나중에 본 쪽은 '중복'
    store.upsert(other, NOW)
    sources = [Source(id="city_jobs", name="시청", collector="generic_board", options={"link_expires": True}),
               Source(id="pen_school_hire", name="교육청", collector="generic_board")]
    postings = [city, other]
    assert prefer_lasting_links(postings, store, sources) == 1
    assert city.url == "https://www.busan.go.kr/woman/whnotice/1759884"
    assert other.url == "https://example.org/pen_school_hire/1"  # 마감 뒤에도 남는 게시판은 그대로


def test_expiring_board_without_twin_keeps_link(tmp_path):
    from busan_jobs.config import Source
    from busan_jobs.pipeline import prefer_lasting_links

    store = Store(tmp_path / "db.sqlite")
    city = _p("city_jobs", "9", "부산광역시 여성문화회관 문화교실 강사 공개모집 공고")
    store.upsert(city, NOW)
    sources = [Source(id="city_jobs", name="시청", collector="generic_board", options={"link_expires": True})]
    assert prefer_lasting_links([city], store, sources) == 0
    assert city.url == "https://example.org/city_jobs/9"
