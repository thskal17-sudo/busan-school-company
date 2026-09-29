"""부산 게시판 목록 파싱 (tests/fixtures/busan_*.html 은 2026-09-29 GitHub 러너에서 받은 실제 화면을 줄인 것).

게시판 옵션은 config/sources.yaml 의 것을 그대로 쓴다 (설정이 바뀌어 파싱이 깨지면 여기서 드러남).
"""
from datetime import date
from urllib.parse import parse_qs, urlsplit

import pytest

from busan_jobs.classify import judge
from busan_jobs.collectors.board import _org_name, parse_board, stable_key
from busan_jobs.config import load_settings, source_rules

TODAY = date(2026, 9, 29)
SOURCES = {s.id: s for s in load_settings().sources}


def rows_of(fixture_bytes, source_id, fixture, page_url=None):
    src = SOURCES[source_id]
    return parse_board(fixture_bytes(fixture), page_url or src.url, src.options, TODAY)


def test_pen_board_data_id_links_and_hidden_labels(fixture_bytes):
    # 부산교육청 학교인력채용: <a class="nttInfoBtn" data-id="1180893" href="javascript:">, 칸마다 <em class="mTit">작성자</em>
    rows = rows_of(fixture_bytes, "pen_school_hire", "busan_pen_hire.html")
    assert [r.key for r in rows] == ["1180895", "1180893", "1180889", "1180887"]
    r = rows[1]
    assert r.title == "2026학년도 가람중학교 문화예술교육 강사 채용 공고"  # 숨은 '새글' 표시는 뺌
    assert r.url == "https://www.pen.go.kr/main/na/ntt/selectNttInfo.do?mi=30367&bbsId=2364&nttSn=1180893"
    assert r.org == "가람중학교"  # 작성자 칸 'ou=가람중학교'
    assert r.posted == date(2026, 9, 29) and r.deadline == date(2026, 10, 7)  # 접수기간 2026/09/29 ~ 2026/10/07
    # 작성자가 담당 교사 이름이면 제목 속 학교 이름을 기관명으로
    assert rows[0].org == "브니엘고등학교"
    assert all(r.detail_ok for r in rows)


def test_pen_board_keyword_filter(fixture_bytes, rules):
    rows = rows_of(fixture_bytes, "pen_school_hire", "busan_pen_hire.html")
    verdicts = {r.title: judge(r.title, rules, True, r.label) for r in rows}
    assert verdicts["2026학년도 가람중학교 문화예술교육 강사 채용 공고"] == "모집중"
    # 조리실무사 결과·통학차량 도우미·기간제교사는 강사 공고가 아님
    assert sum(v == "모집중" for v in verdicts.values()) == 1


def test_afterschool_private_board(fixture_bytes):
    # 부산늘봄지원센터 개인위탁 모집공고: 작성자 칸이 학교 이름, 마감일 칸이 따로 있음
    rows = rows_of(fixture_bytes, "afterschool_private", "busan_afterschool_private.html")
    assert [(r.org, r.posted, r.deadline) for r in rows] == [
        ("구남초등학교", date(2026, 9, 4), date(2026, 9, 10)),
        ("남천초등학교", date(2026, 9, 3), date(2026, 9, 9)),
        ("장림여자중학교", date(2026, 9, 3), date(2026, 9, 4)),
    ]
    assert rows[1].url.endswith("selectNttInfo.do?mi=14360&bbsId=4177&nttSn=1014630")
    assert rows[1].key == "1014630"


def test_eminwon_list_with_detail_template(fixture_bytes):
    # 부산 서구 새올 채용공고: <a href="#" onclick="searchDetail('36862')">
    rows = rows_of(fixture_bytes, "seogu_eminwon", "busan_eminwon_seogu.html")
    assert [r.key for r in rows] == ["36862", "36859", "36852"]
    query = parse_qs(urlsplit(rows[0].url).query)
    assert urlsplit(rows[0].url).netloc == "eminwon.bsseogu.go.kr"
    assert query["method"] == ["selectOfrNotAncmt"] and query["not_ancmt_mgt_no"] == ["36862"]
    assert rows[0].org == "의회사무과" and rows[0].posted == date(2026, 9, 29)


def test_eminwon_old_screen_with_cell_onclick(fixture_bytes):
    # 영도구 새올 옛 화면: 제목에 링크가 없고 <td onclick="javaScript:searchDetail('36478')">, 머리글도 td
    rows = rows_of(fixture_bytes, "yeongdo_eminwon", "busan_eminwon_yeongdo.html")
    assert [r.key for r in rows] == ["36478", "36477", "36463"]
    r = rows[1]
    assert r.title == "2026년 하반기 산림병해충예찰방제단 채용 재공고"  # 고시공고번호 칸이 아니라 제목 칸
    assert r.org == "경제산업과" and r.posted == date(2026, 9, 24)
    assert "not_ancmt_mgt_no=36477" in r.url and r.detail_ok


def test_facility_corp_js_view_links(fixture_bytes):
    # 부산남구시설관리공단: fn_go_view(297) 은 목록 폼을 view.do 로 제출 → 같은 값을 GET 으로
    rows = rows_of(fixture_bytes, "bnfmc_hire", "busan_bnfmc.html")
    r = next(r for r in rows if r.title == "2026년 제4회 시간강사 채용공고")
    assert r.url == "https://www.bnfmc.or.kr/portal/gosiInfo/view.do?mId=0404000000&idx=297"
    assert r.key == "297" and r.posted == date(2026, 6, 11)


def test_city_board_key_ignores_search_period(fixture_bytes):
    # 부산시청 게시판 링크에는 오늘 날짜로 바뀌는 검색 기간(srchBeginDt·srchEndDt)이 붙는다 → 글 식별값에서 뺀다
    rows = rows_of(fixture_bytes, "city_stadium_notice", "busan_city_stadium.html")
    assert rows and all("srch" not in r.key for r in rows)
    assert rows[0].key == "https://www.busan.go.kr/stadium/sfnotice/1756178"
    tomorrow = stable_key(rows[0].url.replace("srchBeginDt=2025-09-29", "srchBeginDt=2025-09-30"))
    assert tomorrow == rows[0].key


def test_source_include_narrows_keywords(rules):
    # 체육시설관리사업소 공지에는 '수영강습 접수 안내' 가 많다 → 이 게시판은 강사·지도자 등만 포함 키워드로
    src = SOURCES["city_stadium_notice"]
    narrow = source_rules(rules, src)
    assert judge("[사직실내수영장] 2026년 10월 수영강습 현장접수 인원안내", rules, True) == "모집중"
    assert judge("[사직실내수영장] 2026년 10월 수영강습 현장접수 인원안내", narrow, True) is None
    assert judge("[사직실내수영장] 2026년 수영강사(프리랜서) 모집 공고", narrow, True) == "모집중"
    assert source_rules(rules, SOURCES["pen_school_hire"]) is rules


def test_list_board_with_selectors(fixture_bytes):
    # 부산일자리정보망 공공채용: 표가 아닌 <ul class="emif-lst"><li><a onclick="show('288592')"> 목록
    rows = rows_of(fixture_bytes, "busanjob_public", "busan_busanjob_public.html")
    r = rows[0]
    assert r.title == "(제2026-8호) 한국보건복지인재원 신규직원(일반공무직_장애) 채용 공고"  # 링크 안의 날짜·기관은 빼고
    assert r.org == "한국보건복지인재원"
    assert (r.posted, r.deadline) == (date(2026, 9, 28), date(2026, 10, 12))  # '2026-09-28 ~ 2026-10-12'
    assert r.url == "https://www.busanjob.net/view.do?no=1309&pgMode=show&id=288592" and r.key == "288592"


@pytest.mark.parametrize(
    "raw, title, expected",
    [
        ("ou=가람중학교", "", "가람중학교"),
        ("최희상", "2026학년도 브니엘고등학교 조리실무사 채용", "브니엘고등학교"),
        ("이승희", "2026학년도 2학기 금양중학교 시간강사(도덕윤리) 채용 공고", "금양중학교"),
        ("김예솔", "한문 기간제교사 채용 공고", ""),
        ("체육진흥과", "", "체육진흥과"),  # 부서 이름은 그대로
        ("서구청", "", "서구청"),
        ("일*과", "", ""),  # 가린 이름
        ("관리자", "부산정관늘봄전용학교 강사 모집", "부산정관늘봄전용학교"),
    ],
)
def test_org_name(raw, title, expected):
    assert _org_name(raw, title) == expected


def test_sources_yaml_is_consistent():
    from busan_jobs.collectors import COLLECTORS

    for src in SOURCES.values():
        assert src.collector in COLLECTORS, src.id
        assert src.enabled or src.options.get("blocked"), f"{src.id}: 끈 소스는 blocked 에 까닭을 적는다"
        template = src.options.get("link_template")
        if template:
            template.format(*["1"] * 8)  # 틀의 {n} 이 모두 채워지는지
