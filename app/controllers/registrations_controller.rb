class RegistrationsController < ApplicationController
  # 공통 코스 조회 필터 지정
  before_action :set_course

  # 1. 기본 수강 신청 처리 과정
  def create
    # 2. 이미 수강신청한 학습자인가?(강의 신청 진행상황에 따른 판단 1)
    if @course.registrations.exists?(user: current_user)
      redirect_to @course, alert: "이미 신청 완료된 강좌입니다. [나의 강의실]에서 확인해 주세요."
      return # 판단 완료시 즉시 해당 메서드를 즉시 종료
    end

    # 3. 강좌의 정원이 모두 채워졌는가?(강의 신청 진행상황에 따른 판단 2)
    if @course.registrations.count >= @course.max_students
      redirect_to @course, alert: "현재 정원이 모두 채워져 강의가 마감되었습니다. 다음에 다시 신청해 주세요."
      return
    end

    # 4. 해당 판단 과정 통과 후 수강신청 데이터에 기록
    @registration = @course.registrations.new(user: current_user)

    if @registration.save
      redirect_to @course, notice: "수강신청이 성공적으로 완료되었습니다. 즐거운 강의가 되시길 바랍니다."
    else
      redirect_to @course, alert: "수강신청 처리 중 오류가 발생했습니다."
    end
  end

  # 5. 수강 취소 처리 과정
  def destroy # 상세 페이지 [수강 신청 취소하기] 버튼과 연결
    # 현재 로그인한 유저가 해당 강좌에 등록한 내역을 정확하게 찾는다.(표적 추적)
    @registration = @course.registrations.find_by(user: current_user)

    if @registration
      if @registration&.destroy
        redirect_to @course, notice: "수강신청이 정상적으로 취소되었습니다."
      else
        redirect_to @course, alert: "취소 처리 중 오류가 발생했습니다."
      end
    else
      redirect_to @course, alert: "해당 권한이 없습니다."
    end
  end

  private

  # 중첩 라우팅 구조에 맞는 부모 클래스 강좌 찾기의 안정성 강화
  def set_course
    @course = Course.find(params[:course_id])
  end
end
