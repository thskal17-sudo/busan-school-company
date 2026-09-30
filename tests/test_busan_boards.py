"""부산 게시판 목록 파싱 (tests/fixtures/busan_*.html 은 2026-09-29 GitHub 러너에서 받은 실제 화면을 줄인 것).

게시판 옵션은 config/sources.yaml 의 것을 그대로 쓴다 (설정이 바뀌어 파싱이 깨지면 여기서 드러남).
"""
from datetime import date
from urllib.parse import parse_qs, urlsplit

import pytest

from busan_jobs.classify import judge
from busan_jobs.collectors.board import _list_date, _org_name, parse_board, stable_key
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
        ("문화의집관리자", "", ""),  # 관리자 계정 이름
        ("", "[모집] 부산진구통합방과후학교 안전도우미 인력 모집 공고", ""),  # 방과후학교는 사업 이름
        ("", "2026학년도 우암초등학교 방과후학교 강사 모집", "우암초등학교"),
        ("", "2026년 학교 밖 청소년 고등학교 검정고시 합격축하금 지원 사업 안내", ""),  # 이름 없는 '고등학교'
        ("", "2026년 사상구학교밖청소년지원센터 신규 학교밖청소년 모집", ""),  # '학교밖'은 학교 이름이 아님
    ],
)
def test_org_name(raw, title, expected):
    assert _org_name(raw, title) == expected


def test_sources_yaml_is_consistent():
    from busan_jobs.collectors import COLLECTORS

    for src in SOURCES.values():
        assert src.collector in COLLECTORS, src.id
        assert src.enabled or src.options.get("blocked"), f"{src.id}: 끈 소스는 blocked 에 까닭을 적는다"
        assert not isinstance(src.options.get("key_param", ""), bool), f"{src.id}: key_param 에 no 를 쓰면 따옴표로"
        template = src.options.get("link_template")
        if template:
            template.format(*["1"] * 8)  # 틀의 {n} 이 모두 채워지는지


def test_bukgu_jobs_board(fixture_bytes):
    # 북구청 일자리정보: 구청 채용공고 게시판, '접수기간' 칸에서 마감일
    rows = rows_of(fixture_bytes, "bukgu_hire", "busan_bukgu_jobs.html")
    r = rows[0]
    assert r.title == "2027년도 환경관리원 공개채용계획 변경 공고"
    assert r.key == "1108008" and r.org == "자원순환과"
    assert (r.posted, r.deadline) == (date(2026, 9, 28), date(2026, 10, 8))
    assert rows[1].title.endswith("..")  # 목록에서 잘린 제목 → 강사 공고면 상세에서 전체 제목을 받는다


def test_gangseo_gosi_all_notices(fixture_bytes):
    # 강서구 새올 고시공고 전체: 채용공고(05)가 비어 있어 모집 공고가 섞인 고시공고를 키워드로 거른다
    rows = rows_of(fixture_bytes, "gangseo_gosi", "busan_eminwon_gangseo_gosi.html")
    assert [r.key for r in rows] == ["41291", "41289", "41284"]
    assert "not_ancmt_mgt_no=41289" in rows[1].url and urlsplit(rows[1].url).netloc == "eminwon.bsgangseo.go.kr"
    assert rows[1].org == "안전관리과" and rows[1].posted == date(2026, 9, 29)


def test_women_center_aspx_board(fixture_bytes):
    # 부산진·동래·사하 여성인력개발센터 공통 게시판: sub1_view.aspx?b=글번호
    rows = rows_of(fixture_bytes, "bswoman_notice", "busan_bswoman_notice.html")
    r = rows[0]
    assert r.title == "[채용공고] 부산진여성새로일하기센터 취업상담사 모집공고(긴급)"
    assert r.key == "855" and r.posted == date(2026, 9, 28)
    assert r.url == "https://www.bswoman.or.kr/sub4/sub1_view.aspx?b=855&p=0&cdt=&txt="


def test_women_center_list_board(fixture_bytes):
    # 해운대여성인력개발센터: <ul class="bbsList"><li> 목록, 날짜는 '26.09.04', 글 주소는 zipEncode 로 감쌈
    rows = rows_of(fixture_bytes, "hwcenter_notice", "busan_hwcenter_notice.html")
    assert [r.posted for r in rows] == [date(2026, 9, 4), date(2026, 6, 15), date(2026, 4, 24)]
    assert rows[0].title == "★교육비 전액 지원★ 홈케어(정리수납2급) 마스터 양성과정 교육생 모집"
    assert all(r.url.startswith("https://www.hwcenter.or.kr/SW_bbs/notice/view.php?zipEncode=") for r in rows)
    assert len({r.key for r in rows}) == 3


def test_women_center_board_with_private_posts(fixture_bytes, rules):
    # 동구여성인력개발센터: bbs_uid 글번호, '비밀글 입니다.' 줄은 링크가 없어 강사 공고로 잡히지 않는다
    rows = rows_of(fixture_bytes, "donggu_woman_notice", "busan_ewoman_notice.html")
    assert [r.key for r in rows[:2]] == ["199", "187"]
    assert rows[0].title == "(동구새일) 직업상담사 채용공고(직업상담사, 육아휴직대체근무자)"
    assert judge(rows[2].title, rules, True) is None


def test_youth_hire_list_strips_org_from_title(fixture_bytes, rules):
    # 부산청소년활동진흥센터 채용정보: <li><span class="tit"><span>기관</span> 제목</span>, 바로가기는 u_re('글번호','공고 주소')
    rows = rows_of(fixture_bytes, "busanyouth_hire", "busan_busanyouth_hire.html")
    r = rows[2]
    assert r.title == "2026년 해운대청소년수련관 청소년활동팀 팀원 채용 공고" and r.org == "해운대청소년수련관"
    assert r.key == "234760" and r.posted == date(2026, 9, 8)
    assert r.url.startswith("https://www.work24.go.kr/wk/a/b/1500/empDetailAuthView.do?wantedAuthNo=K130112609080079")
    assert rows[0].org == "동래구청소년지원센터꿈드림"
    # 직원 채용은 청소년 기관용 포함 키워드(강사·코치·활동지도자 등)에 걸리지 않는다
    narrow = source_rules(rules, SOURCES["busanyouth_hire"])
    assert all(judge(r.title, narrow, True) is None for r in rows)


def test_youth_center_onclick_board(fixture_bytes, rules):
    # 사상구청소년센터(금곡·구덕과 같은 제작사): 제목 칸 <td onclick="location.href='/sb55.php?md=V&idx=…'">,
    # 위쪽 메뉴 표도 td onclick 이라 row_selector 로 게시판 줄만 고른다
    rows = rows_of(fixture_bytes, "yzzang_hire", "busan_yzzang_hire.html")
    assert [r.key for r in rows] == ["1810", "1784", "1768", "1757"]
    r = rows[2]
    assert r.title == "긴급) 주말방과후아카데미 활동지도자 채용 공고" and r.posted == date(2026, 8, 4)
    assert r.url.startswith("https://www.yzzang.com/sb55.php?md=V&idx=1768")
    narrow = source_rules(rules, SOURCES["yzzang_hire"])
    verdicts = [judge(r.title, narrow, True) for r in rows]
    assert verdicts == [None, None, "모집중", None]  # 아르바이트·학교밖센터 직원·최종합격자 안내는 거름
    assert judge(rows[1].title, narrow, True, keep_results=True) == "결과공고"


def test_youth_notice_keywords(rules):
    narrow = source_rules(rules, SOURCES["busanyouth_notice"])
    assert judge("[모집]2026년 청소년자원봉사 신규 교육강사", narrow, True) == "모집중"
    assert judge("주말형청소년방과후아카데미 음악(기타/베이스/드럼), 뉴스포츠 강사 모집 공고", narrow, True) == "모집중"
    assert judge("2026 청소년방과후아카데미 신규 청소년 모집", narrow, True) is None
    assert judge("청소년지도사 채용 공고", narrow, True) is None
    assert judge("방과후과정 지원 자원봉사자 모집", rules, True) is None
    # 멘토: 꿈드림 검정고시 학습멘토처럼 가르치는 사람을 뽑는 글은 남기고, 멘토링에 참가할 청소년 모집은 거름
    assert judge("[꿈드림] 검정고시대비반 '스마트교실' 멘토 모집", narrow, True) == "모집중"
    assert judge("수영구학교밖청소년지원센터 검정고시 학습멘토 모집", narrow, True) == "모집중"
    assert judge("2026년 영도구학교밖청소년지원센터 꿈드림 멘토단 모집(모집완료)", narrow, True) is None
    assert judge("[홍보] 2026 청소년 방과후 아카데미 통통한 멘토링 참가 신청", narrow, True) is None
    assert judge("2026 청소년 멘토링 프로그램 참여자 모집", narrow, True) is None


def test_xe_board_same_key_for_both_link_forms(fixture_bytes, rules):
    # 부산진구 부전 청소년센터(XE): 공지 줄은 /xe/sub7_01/24564, 일반 줄은 index.php?…&document_srl=24556
    # → key_pattern 으로 글번호만 식별값으로 (공지에서 내려와도 같은 글)
    rows = rows_of(fixture_bytes, "bujeon_youth_notice", "busan_teenstory_notice.html")
    assert [r.key for r in rows] == ["24564", "24556", "24288", "24273", "24153"]
    assert rows[0].url == "https://teenstory.kr/xe/sub7_01/24564" and rows[0].org == ""  # '통합방과후학교'는 기관명 아님
    assert rows[4].title == "청소년방과후아카데미 강사 모집 공고(댄스)" and rows[4].posted == date(2026, 2, 11)
    narrow = source_rules(rules, SOURCES["bujeon_youth_notice"])
    verdicts = [judge(r.title, narrow, True) for r in rows]
    assert verdicts == [None, None, None, None, "모집중"]  # 안전도우미·직원 합격자·'[마감]' 강사 공고는 거름


def test_onclick_board_with_pc_and_mobile_lists(fixture_bytes):
    # 중구청소년문화의집: 같은 목록이 <div id="only_pc">·<div id="only_mobile"> 에 두 번 → PC 쪽만 (날짜 칸이 있음)
    rows = rows_of(fixture_bytes, "purun1318_notice", "busan_purun1318_notice.html")
    assert [(r.key, r.posted) for r in rows] == [("1672", date(2026, 6, 30)), ("1647", date(2026, 4, 7))]


@pytest.mark.parametrize(
    "text, expected",
    [
        ("09-03", date(2026, 9, 3)),
        ("11-18", date(2025, 11, 18)),  # 오늘(9/29)보다 뒤 → 작년 글
        ("09-29", date(2026, 9, 29)),
        ("2026-04-02", date(2026, 4, 2)),
        ("10:57", None),  # 오늘 글은 시각만
    ],
)
def test_list_date_without_year(text, expected):
    # 그누보드 기본 목록(남구청소년상담복지센터)은 날짜를 '09-03' 으로만 보여 준다
    assert _list_date(text, TODAY) == expected


def test_ajax_list_with_js_form_links(fixture_bytes, rules):
    # 해운대구청소년상담복지센터: 화면이 AJAX 로 불러오는 목록(mode=list_ok)을 바로 받고,
    # 제목 링크 onclick="view('270')" (GET 폼 제출) → link_template 로 mode=view&uid=270
    rows = rows_of(fixture_bytes, "udream_notice", "busan_udream_notice.html")
    assert [(r.key, r.posted) for r in rows] == [
        ("267", date(2026, 9, 9)), ("270", date(2026, 9, 23)), ("258", date(2026, 1, 27)),
    ]
    assert rows[2].url == "http://u-dream.or.kr/04/01.php?mode=view&uid=258" and rows[2].detail_ok
    narrow = source_rules(rules, SOURCES["udream_notice"])
    assert [judge(r.title, narrow, True) for r in rows] == [None, None, "모집중"]  # '전문강사 모집 공고'만


def test_gnuboard_li_list(fixture_bytes):
    # 사하구청소년상담복지센터: 그누보드인데 표가 아닌 <li class="gw_tb_tr"> 목록
    rows = rows_of(fixture_bytes, "saha1388_notice", "busan_saha1388_notice.html")
    assert [(r.key, r.posted) for r in rows] == [
        ("186", date(2026, 7, 24)), ("189", date(2026, 9, 2)), ("188", date(2026, 8, 31)),
    ]
    assert rows[1].title == "2026년 학교 밖 청소년 수학여행 지원사업 수의계약 내역 공개"


def test_child_center_hire_board_org_from_writer(fixture_bytes, rules):
    # 지역아동센터 부산지원단 인재채용: 작성자 칸이 공고를 올린 기관(○○지역아동센터·○○구청)
    rows = rows_of(fixture_bytes, "bro3c_hire", "busan_bro3c_hire.html")
    assert [(r.key, r.org) for r in rows] == [
        ("https://www.bro3c.org/5_4/74004", "부산 영도구"),
        ("https://www.bro3c.org/5_4/73998", "부곡지역아동센터"),
        ("https://www.bro3c.org/5_4/73989", "한나래지역아동센터"),
    ]
    narrow = source_rules(rules, SOURCES["bro3c_hire"])
    # 구청 아동복지교사·프로그램 강사는 받고, 돌봄 보조인력은 거름
    assert [judge(r.title, narrow, True) for r in rows] == ["모집중", None, "모집중"]
    assert judge("[부산 부산진구] 수지역아동센터 생활복지사 채용공고", narrow, True) is None


def test_child_center_national_board_filtered_to_busan(fixture_bytes, rules):
    # 아동권리보장원 구인게시판: 시도 '부산' 으로 거른 목록, fnDetail('17686') → GET 상세, 모집기간 칸에서 마감일
    rows = rows_of(fixture_bytes, "icare_busan_hire", "busan_icare_hire.html")
    assert [r.key for r in rows] == ["17686", "17662", "17607"]
    r = rows[0]
    assert r.url == (
        "https://www.icareinfo.go.kr/notice/jobOffer/jobOfferDetail.do?bbs_no=17686&menuNo=3001110&bbs_section_cd=job"
    )
    assert (r.posted, r.deadline) == (date(2026, 6, 10), date(2026, 6, 19))
    narrow = source_rules(rules, SOURCES["icare_busan_hire"])
    assert [judge(r.title, narrow, True) for r in rows] == ["모집중", None, "모집중"]  # 사회복지사 채용은 거름


def test_imweb_board_date_attr_and_title_org(fixture_bytes, rules):
    # 부산광역시사회복지협의회 취업정보(아임웹): 날짜 칸 글자는 '2일전' 이고 title 속성에 '2026-09-28 14:35',
    # 기관명은 제목 앞 [대괄호] 에서 (title_org_pattern)
    rows = rows_of(fixture_bytes, "bswin_job", "busan_bswin_job.html")
    assert [(r.key, r.posted, r.org) for r in rows] == [
        ("174853397", date(2026, 9, 28), "KRX국민행복재단"),
        ("174658524", date(2026, 9, 23), "송도사랑요양원"),
        ("173872331", date(2026, 9, 8), "늘봄실버요양센터"),
    ]
    narrow = source_rules(rules, SOURCES["bswin_job"])
    assert all(judge(r.title, narrow, True) is None for r in rows)  # 요양보호사·조리원 등은 거름 ('늘봄'실버요양센터 포함)
    assert judge("[운봉종합사회복지관] 수면요가테라피 강사 모집", narrow, True) == "모집중"
