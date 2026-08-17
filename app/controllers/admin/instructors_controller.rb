module Admin
  class InstructorsController < ApplicationController
    # 접근 권한 검증
    before_action :require_authentication
    before_action :ensure_admin!

    # 강사 현황 및 강사료 정산 통합 목록
    def index
      @instructors = InstructorProfile.includes(:user, :course, :instructor_payrolls)
      @unpaid_payrolls = InstructorPayroll.unpaid_list.includes(instructor_profile: :user, course: [])
      @processed_payrolls = InstructorPayroll.processed_list.includes(instructor_profile: :user, course: []).order(updated_at: :desc).limit(10)
    end

    # 강사료 지급 승인 및 확인
    def process_payroll
      payroll = InstructorPayroll.find(params[:payroll_id])
      payroll.process_payment!
      redirect_to admin_instructors_path, notice: "강사료 지급 처리가 완료되었습니다."
    end
  end
end
