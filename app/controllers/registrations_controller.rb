class RegistrationsController < ApplicationController
  # 1. 로그인 실패시 로그인 페이지로 이동
  before_action :authenticate_user!

  def create
    @course = Course.find(params[:course_id])

    # 2. 이미 수강신청한 학습자인가?(강의 신청 진행상황에 따른 판단 1)
    if @course.users.include?(current_user)
      redirect_to @course, alert: "이미 신청 완료된 강좌입니다. [나의 강의실]에서 확인해 주세요."

    # 3. 강좌의 정원이 모두 채워졌는가?(강의 신청 진행상황에 따른 판단 2)
    elsif @course.registrations.count >= @course.max_students
      redirect_to @course, alert: "현재 정원이 모두 채워져 강의가 마감되었습니다. 다음에 다시 신청해 주세요."

    # 4. 해당 판단 과정 통과시 대출 대장에 기록
    else
      @course.users << current_user
      respond_to @course, notice: "수강신청이 성공적으로 완료되었습니다. 즐거운 강의가 되시길 바랍니다."
    end
  end
end
