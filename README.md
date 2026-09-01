---
# 🏛️ 롱라이프 평생학습관 LMS (LongLifeEduLms)

> 시민들을 위한 평생교육 강좌 수강신청 및 학습관 시설 대관을 통합적으로 지원하는 웹 기반 학습 관리 시스템(LMS)입니다.

[Ruby](https://img.shields.io/badge/Ruby-4.0-CC342D?style=flat-square&logo=ruby&logoColor=white)
[Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-8.0-CC0000?style=flat-square&logo=rubyonrails&logoColor=white)
[Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=flat-square&logo=tailwindcss&logoColor=white)
[SQLite](https://img.shields.io/badge/SQLite3-003B57?style=flat-square&logo=sqlite&logoColor=white)

<br>

## 📌 프로젝트 개요
**롱라이프 평생학습관 LMS**는 오프라인 평생교육 인프라를 디지털로 전환하여, 누구나 쉽게 양질의 교육에 접근하고 학습관 시설을 이용할 수 있도록 설계되었습니다. 
수강생, 강사, 관리자의 역할을 명확히 분리(RBAC)하여 각 사용자에게 최적화된 대시보드와 기능을 제공합니다.

<br>

## 💡 주요 기능 (Key Features)

### 1. 사용자 맞춤형 수강 신청 & 대시보드
* **실시간 수강신청:** 강좌 정원 및 현재 신청 인원을 실시간으로 반영하여 수강 신청 및 취소 기능 제공
* **나의 강의실:** `CourseRegistration` 모델 기반의 M:N 연관 관계를 통해 신청한 강좌 내역 및 진행 상태를 대시보드에서 직관적으로 확인

### 2. 시설 대관 관리 시스템
* **스마트 대관 신청:** 다목적 세미나실, 강당 등 시설 목록 조회 및 예약 신청
* **관리자 승인 프로세스:** Enum 상태값(대기/승인/반려)을 활용하여 데이터 타입 정합성을 보장하고, 관리자가 신청 내역을 직관적으로 검토·처리할 수 있는 백오피스 제공

### 3. 동적 필터링 기반 공지사항 게시판
* 중요 공지 상단 고정(`is_pinned`) 및 카테고리(모집안내, 행사/소식, 시설/대관) 동적 필터링 적용
* ActiveRecord 쿼리 체이닝을 활용한 제목 및 내용 통합 검색 지원

### 4. 검색엔진 최적화 (SEO) 및 사이트맵 이원화
* **XML 사이트맵 (`sitemap.xml`):** `sitemap_generator`를 활용해 동적 라우트 자동 수집 및 민감한 엔드포인트(마이페이지 등) 배제
* **HTML 사이트맵 (`sitemap.html`):** 사용자 경험(UX)을 고려한 카드형 그리드 UI의 사이트맵 제공

<br>

## ⚙️ 아키텍처 및 개발 원칙 (Engineering Principles)

* **Strict MVC & Fat Model:** 데이터 상태 검증 및 UI 가공 비즈니스 로직(예: `display_instructor_name`)을 Model에 철저히 위임하여 Controller 과부하 방지.
* **정적 페이지 라우팅 중앙화:** `StaticPagesController`를 도입하여 단순 정보성 페이지(기관소개, 이용안내 등)로 인한 불필요한 컨트롤러 확장을 막고 메모리 파편화 방지.
* **데이터 무결성 및 N+1 쿼리 최적화:** Raw SQL을 배제하고 Rails의 Scope, Enum, `includes`/`references`를 적극 활용하여 쿼리 성능 최적화.
* **강건한 데이터 시딩 (Robust Seeding):** `db:seed` 실행 시 `begin-rescue` 구문을 적용하여 유효성 검증 에러 발생 시 진행이 멈추지 않고 상세 로그를 터미널에 출력하도록 설계.

<br>

## 🛠️ 기술 스택 (Tech Stack)

* **Backend:** Ruby 4.0, Ruby on Rails 8.0
* **Frontend:** Tailwind CSS, ERB(Embedded Ruby), Hotwire
* **Database:** SQLite3
* **Version Control:** Git, GitHub
* **IDE:** Visual Studio Code

<br>

## 🚀 설치 및 실행 방법 (Getting Started)

### 1. 저장소 클론
```bash
git clone [https://github.com/본인계정/long-life-edu-lms.git](https://github.com/본인계정/long-life-edu-lms.git)
cd long-life-edu-lms

```

### 2. 의존성 패키지 설치

```bash
bundle install

```

### 3. 데이터베이스 세팅 및 시드 데이터 생성

```bash
# SQLite3 기반 데이터베이스 생성 및 마이그레이션
rails db:create
rails db:migrate
rails db:seed

```

### 4. 서버 실행

```bash
# 별도의 터미널(VS Code 분할 터미널 권장)에서 Tailwind CSS 실시간 빌드
rails tailwindcss:watch

# 메인 터미널에서 Rails 서버 실행
rails server # 짧게 rails s로 쓰셔도 서버가 실행됩니다.

```

* 브라우저에서 `http://localhost:3000` 으로 접속하여 확인하실 수 있습니다.

## 👨‍💻 개발자 정보 (Contact)

* **Name:** [정재웅]
* **Email:** [toho1123@naver.com], [jjw5723844@gmail.com]
