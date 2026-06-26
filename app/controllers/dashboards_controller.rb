class DashboardsController < ApplicationController
  def index
    # 이용자가 신청한 강좌 목록을 가져오되, 카테고리와 신청인원 데이터를 한 번에 가져오도록 설정한다.
    @enrolled_courses = current_user.enrolled_courses
                                    .includes(:category, :registrations)
                                    .order("registrations.created_at DESC")
  end
end
