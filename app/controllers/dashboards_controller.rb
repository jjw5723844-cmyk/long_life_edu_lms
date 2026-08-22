class DashboardsController < ApplicationController
  # 학습관 이용자의 마이페이지 접근 권한 확인
  before_action :require_authentication, if: -> { respond_to?(:require_authentication, true) }

  def index
    # 이용자가 신청한 강좌 목록을 가져오되, 카테고리와 신청인원 데이터를 한 번에 가져오도록 설정한다.
    @enrolled_courses = current_user.enrolled_courses
                                    .includes(:category, :registrations)
                                    .references(:registrations) # 정렬 오류 방지(데이터베이스 조인 참조)
                                    .order("registrations.created_at DESC")
  end

  def show # 세션 컨트롤러의 redirect_to dashboard_path(단수형) 호출 시 에러가 나지 않도록 show 액션을 확보
    index
    render :index # 세션 컨트롤러의 redirect_to dashboard_path(단수형) 호출 시 에러가 나지 않도록 show 액션을 출력
  end
end
