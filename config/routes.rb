Rails.application.routes.draw do
  resources :categories
  devise_for :users

  # 강좌 안에 수강신청 경로를 중첩시킨다.
  resources :courses do
    resources :registrations, only: [ :create, :destroy ]
  end

  # 강좌 목록 페이지 설정
  root "courses#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
