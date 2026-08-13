module Admin
  class Admin::InstructorsController < ApplicationController
    # 관리자 접근 권한 검증
    before_action :require_admin

    # 강사 현황 및 강사료 정산 통합 목록
    def index
      @instructors = InstructorProfile.includes(:user, :course, :instructor_payrolls)
      @unpaid_payrolls = InstructorPayroll.unpaid_list.includes(instructor_profile: :user, course: :title)
      @processed_payrolls = InstructorPayroll.processed_list.includes(instructor_profile: :user, course: :title).order(updated_at: :desc).limit(10)
    end

    # 강사료 지급 승인 및 확인
    def process_payroll
      payroll = InstructorPayroll.find(params[:payroll_id])
      payroll.pricess_payment!
      redirect_to admin_instructors_path, notice: "강사료 지급 처리가 완료되었습니다."
    end

    private

    # 관리자 권한 확인
    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "관리자 전용 기능입니다."
      end
    end
  end
end
