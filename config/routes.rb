Rails.application.routes.draw do
  # 로그인/로그아웃 담당
  resource :session

  # 비밀번호 재설정 관련 라우트
  resources :passwords, param: :token

  # 카테고리 관련 라우트
  resources :categories

  # 강좌 안에 수강신청 경로를 중첩시킨다.
  resources :courses do
    resources :registrations, only: [ :create, :destroy ]
  end

  # 강좌 목록 페이지 설정
  root "courses#index"
  get "up" => "rails/health#show", as: :rails_health_check

  # 학습자용 강의실 대시보드 주소 추가
  get "dashboard", to: "dashboards#index", as: :dashboard
end
