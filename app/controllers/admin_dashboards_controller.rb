class AdminDashboardsController < ApplicationController
  # 어드민 컨트롤러가 실행되기전 로그인한 유저가 관리자인지 판단(보안 강화)
  before_action :ensure_admin!

  def index
    # 스키마 파일의 데이터들을 분석하여 존재가 확인되는 데이터 테이블들의 통계와 목록을 정렬
    @total_users_count = User.count
    @total_courses_count = Course.count
    @total_regstrations_count = Registration.count

    # 관리자가 관리자 제어 센터에서 관리할 전체 목록 데이터들을 표기
    @all_users = User.order(created_at :desc)
    @all_courses = Course.include(:user, :category).order(created_at :desc)
  end

  private

  # 보안 로직: 유저(User) 모델의 enum 기능인 admin? 메서드를 통해 관리자가 아니라면 메인 페이지로 이동
  def ensure_admin?
    unless current_user&.admin?
      redirect_to root_path, alert: "접근 권한이 없습니다. 관리자만 진입할 수 있습니다."
    end
  end
end
