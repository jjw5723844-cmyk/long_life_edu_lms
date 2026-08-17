module Admin
  class CourseRegistrationsController < ApplicationController
    # 접근 권한 검증
    before_action :require_authentication
    before_action :ensure_admin!

    before_action :set_registration, only: [:approve_discount, :reject_discount, :process_refund]

    # 수강신청/감면/대기자 종합 관리 목록
    def index
      @pending_discounts = CourseRegistration.pending_discounts.includes(:user, :course)
      @waitlist_registrations = CourseRegistration.where(status: :waitlisted).includes(:user, :course).order(waitlist_position: :asc)
      @completed_registrations = CourseRegistration.where(status: [:confirmed, :refunded, :cancelled]).includes(:user, :course).order(updated_at: :desc).limit(20)
    end

    # 감면 승인
    def approve_discount
      @registration.approve_discount!
      redirect_to admin_course_registrations_path, notice: "수강료 감면 신청이 승인되었습니다."
    end
    # 감면 반려
    def reject_discount
      @registration.reject_discount!
      redirect_to admin_course_registrations_path, notice: "수강료 감면 신청이 반려되었습니다."
    end
    # 수강 포기 및 환불 정산 처리
    def process_refund
      @registration.process_cancellation_and_refund!
      redirect_to admin_course_registrations_path, notice: "수강 취소 및 환불 정산 처리가 완료되었습니다."
    end

    private

    # ID 기반 대상 데이터 검색
    def set_registration
      @registration = CourseRegistration.find(params[:id])
    end
  end
end
