module Admin
  class Admin::FacilityReservationsController < ApplicationController
    # 관리자 접근 권한 검증
    before_action :require_admin
    # 해당 대상 대관 건수 조회
    before_action :set_reservation, only: [:approve, :reject]

    # 대관 승인 대기 및 내역 목록
    def index
      @pending_reservations = FacilityReservation.waiting_approval.includes(:facility, :user)
      @processed_reservations = FacilityReservation.processed_history.includes(:facility, :user)
    end

    # 대관 신청 승인
    def approve
      @reservation.approve!
      redirect_to admin_facility_reservations_path, notice: "시설 대관 신청이 승인되었습니다."
    end

    # 대관 신청 반려
    def reject
      @reservation.reject!
      redirect_to admin_facility_reservations_path, notice: "시설 대관 신청이 반려되었습니다."
    end

    private

    # ID 기반 대관 데이터 조회
    def set_reservation
      @reservation = FacilityReservation.find(params[:id])
    end

    # 관리자 권한 확인
    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "관리자 전용 기능입니다."
      end
    end
  end
end
