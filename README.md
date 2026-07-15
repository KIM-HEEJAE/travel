# ✈ TravelSite - 여행 커뮤니티 & 예약 플랫폼

여행 후기 공유부터 항공권/숙소 예약, AI 여행 상담, 취향 통계까지 한 곳에서 제공하는 웹 애플리케이션입니다.

## 📌 프로젝트 소개

여행을 준비하는 사람들이 후기를 나누고, 항공권과 숙소를 검색·예약하고, AI에게 여행 상담을 받을 수 있는 종합 여행 플랫폼을 목표로 제작했습니다. 실시간 항공권/숙소 API 대신 자체 DB에 샘플 데이터를 구축하여, 실제 서비스와 동일한 조회·검색·예약 흐름을 구현했습니다.

## 🛠 기술 스택

| 구분 | 기술 |
|---|---|
| Backend | Spring MVC, MyBatis |
| Database | Oracle |
| Frontend | JSP, JSTL, jQuery, Ajax |
| AI | Google Gemini API |
| 인증/보안 | Spring Security Crypto (BCrypt) |
| 시각화 | Chart.js |
| 빌드 | Maven |
| 버전 관리 | Git / GitHub |

## ✨ 주요 기능

### 1. 회원 시스템
- 회원가입 / 로그인 / 로그아웃 (세션 기반)
- 비밀번호 BCrypt 암호화
- 아이디 중복 확인 (Ajax)
- 마이페이지: 내 정보 조회, 회원정보 수정, 비밀번호 변경
- 관리자 권한 분리 (일반 회원 / 관리자)

### 2. 게시판 (여행 후기 커뮤니티)
- 게시글 CRUD, 페이징, 검색(제목/내용), 카테고리 분류
- 이미지 업로드 및 표시
- 댓글 CRUD (Ajax, 실시간 반영)
- 좋아요 토글 기능

### 3. 여행 취향 분석
- 여행 스타일 / 예산대 / 국내외 선호 설문
- Chart.js를 활용한 원형·막대 그래프 통계 대시보드
- 게시판 데이터 기반 인기 여행지 TOP5 시각화

### 4. AI 여행 상담 챗봇
- Google Gemini API 연동
- 실시간 Q&A 채팅 UI (Ajax)
- 로그인 회원의 상담 기록 자동 저장 및 조회

### 5. 항공권 예약
- 국내선/국제선 검색 (출발지·도착지·유형 필터)
- 예약 및 내 예약 목록 관리
- 예약 취소 (출발 24시간 이내 취소 제한)
- 예약 건수 기반 인기 항공권 홈 노출

### 6. 숙소 예약
- 지역/숙소유형별 검색
- 체크인·체크아웃 날짜 기반 숙박일수 및 총 결제금액 자동 계산
- 예약 취소 (체크인 24시간 이내 취소 제한)
- 숙박 완료 후 리뷰 작성 (평점 + 후기)
- 리뷰 평균 기반 평점 자동 갱신 및 추천 숙소 노출

### 7. 관리자 페이지
- 관리자 전용 대시보드
- 항공권 등록 / 수정 / 삭제
- 숙소 등록 / 수정 / 삭제

### 8. 기타
- 커스텀 404 / 500 에러 페이지
- 공통 헤더 컴포넌트 및 공통 스타일시트(style.css) 기반 UI 일관성 유지

## 🗂 ERD 개요

```
TRV_MEMBER ──┬── TRV_BOARD ──── TRV_COMMENT
             │              └── TRV_LIKE
             ├── TRV_MEMBER_PREFERENCE
             ├── TRV_CHAT_LOG
             ├── TRV_RESERVATION ──── TRV_FLIGHT
             └── TRV_HOTEL_RESERVATION ──┬── TRV_HOTEL
                                          └── TRV_HOTEL_REVIEW
```

## 📁 프로젝트 구조

```
src/main/java/com/travel/
├── controller/   # 요청 처리
├── service/      # 비즈니스 로직
├── mapper/       # MyBatis 매퍼 인터페이스
├── dto/          # 데이터 전송 객체
└── util/         # 페이징 등 유틸리티

src/main/resources/
├── mappers/      # MyBatis XML 쿼리
└── mybatis-config.xml

src/main/webapp/
├── resources/css/style.css   # 공통 스타일
└── WEB-INF/views/            # JSP 화면
```

## 🚀 실행 방법

1. Oracle DB 생성 후 테이블 스키마 실행
2. `src/main/resources/config.properties`에 Gemini API 키, DB 정보, 업로드 경로 설정
3. `WEB-INF/spring/root-context.xml`에 DB 접속 정보 확인
4. STS(Eclipse)에서 프로젝트 Import → Maven Update → Tomcat 서버 실행
5. 브라우저에서 `http://localhost:8080/TravelSite/` 접속

## 🔒 보안 관련 안내

`config.properties`는 API 키 및 DB 계정 정보를 포함하므로 `.gitignore`에 등록되어 Git에 커밋되지 않습니다. 프로젝트 실행 시 해당 파일을 직접 생성해야 합니다.

```properties
gemini.api.key=YOUR_GEMINI_API_KEY
gemini.api.url=https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent
upload.path=C:/work/travelimg/
```

## 📝 향후 개선 방향

- 서버단 입력값 검증 강화
- 예약 처리 트랜잭션 적용
- 모바일 반응형 UI
- 파일 업로드 확장자/용량 서버단 검증

## 👤 개발자

개인 포트폴리오 프로젝트 (2026)
