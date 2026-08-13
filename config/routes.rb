Rails.application.routes.draw do
  # 시설 대관 관리 경로 라우트
  resources :facilities, only: [:index, :show] do
    resources :facility_reservations, only: [:new, :create] # 시설 중첩 라우트로 예약 신청 기능 경로 추가
  end

  # 사용자 본인의 대관 신청 내역 관리 전역 라우트
  resources :facility_reservations, only: [:index, :show, :destroy]

  # 학습동아리 메뉴 경로 라우트
  resources :clubs do
    collection do
      get :gallery # 동아리 활동 갤러리 페이지
    end
    member do
      post :join # 동아리 가입 신청 및 취소의 동적 처리 수행
    end
  end

  # 이용안내 메뉴 경로 라우트
  resources :guides, only: ["index"] do
    collection do
      get "registration" # 수강신청 안내 페이지 경로
      get "facility" # 시설 이용안내 페이지 경로

      # 대관 신청 및 대관 시설 이용 내역 페이지를 이용안내 메뉴의 하위 메뉴로 경로 설정
      get "facilitis", to: "facilities#index", as: :guide_facilities
      get "reservations", to: "facility_reservations#index", as: :guide_reservations
    end
  end

  get "instructors/index" # 강사소개
  get "notcices/index"  # 공지사항
  get "pags/about" # 기관소개

  ## 1. 인증 및 계정 관리 시스템

  # 로그인/로그아웃 담당
  resource :session

  # 비밀번호 재설정 관련 라우트
  resources :passwords, param: :token

  ## 2. 강좌 운영 및 수강 신청 시스템

  # 카테고리 관련 라우트
  resources :categories

  # 강좌 안에 수강신청 경로를 중첩시킨다.
  resources :courses do
    resources :registrations, only: [ :create, :destroy ] # 강좌와 수강신청 관계를 연결
    resources :course_reviews, only: [ :index, :create, :destroy ] # 강좌 상세 페이지 내부에서 후기 작성 및 삭제를 정상적으로 처리하도록 중첩 라우팅 설정
  end

  # 강좌 목록 페이지 설정(메인 화면)
  root "courses#index"

  # 레일즈 시스템 헬스 체크 엔드포인트
  get "up" => "rails/health#show", as: :rails_health_check

  ## 3. 권한별 전역 제어 대시보드

  # 일반 학습자용 마이페이지 강의실
  get "dashboard", to: "dashboards#index", as: :dashboard

  # 강사용 강좌 개설 및 출석 제어 센터 설정
  get "teacher/dashboard", to: "teacher_dashboards#index", as: :teacher_dashboard

  # 관리자용 시스템 제어 센터
  get "admin/dashboard", to: "admin_dashboards#index", as: :admin_dashboard

  # 기관소개 정적 페이지 라우트
  get "about", to: "static_pages#about", as: :about

  # 공지사항 게시판 라우트
  get "notices", to: "notices#index", as: :notices
  resources :notices, only: [ :index, :show ]

  # 강사 소개 페이지 라우트
  resources :instructors, only: [:index]

  # 사이트맵 매핑 라우트
  get "sitemap", to: "static_pages#sitemap", as: :sitemap

  # 관리자 기능 라우트 
  namespace :admin do
    # 수강 신청/감면/환불 승인 관리
    resources :course_registrations, only: [:index] do
      member do
        patch :approve_discount
        patch :reject_discount
        patch :process_refund
      end
    end

    # 출강 강사 및 강사료 정산 관리 
    resources :instructors, only: [:index] do
      collection do
        patch :process_payroll
      end
    end

    # 교육관 학습동아리 관리
    resources :clubs, only: [:index] do
      member do
        patch :approve
        patch :reject
      end
      collction do
        patch :review_report
      end
    end

    # 시설 대관 승인 관리
    resources :facility_reservations, only: [:index] do
      member do
        patch :approve
        patch :reject
      end
    end
  end
end
