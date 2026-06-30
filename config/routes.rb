Rails.application.routes.draw do
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
end
