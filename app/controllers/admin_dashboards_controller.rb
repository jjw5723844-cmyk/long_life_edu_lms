class AdminDashboardsController < ApplicationController
  # 미인증 사용자는 로그인 페이지로, 로그인된 일반 유저는 메인 페이지로 안전하게 차단하도록 순서 명시(보안 강화)
  before_action :require_authentication
  before_action :ensure_admin!

  def index
    # 스키마 파일의 데이터들을 분석하여 존재가 확인되는 데이터 테이블들의 통계와 목록을 정렬
    @total_users_count = User.count
    @total_courses_count = Course.count
    @total_regitrations_count = Registration.count

    # 관리자가 관리자 제어 센터에서 관리할 전체 목록 데이터들을 표기
    @all_users = User.order(created_at: :desc)
    @all_courses = Course.includes(:user, :category).order(created_at: :desc)
  end
end