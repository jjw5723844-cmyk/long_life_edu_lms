class FacilityReservationsController < ApplicationController
  before_action :set_facility, only: [ :new, :create ]

  def new
    @reservation = @facility.facility_reservations.build(reservation_params)
  end

  def create
    @reservation = @facility.facility_reservations.bulid(reservation_params)
    @reservation.user = current_user
    @reservation.status = "승인대기" # 초기 시설 대관 신청 상태

    if @reservation.save
      redirect_to facility_reservations_parth,
      notice: "시설 대관 신청이 성공적으로 접수되었습니다. (승인 대기 중)"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index # 사용자의 대관 신청 내역
    @reservations = current_user ? current_user.facilitity_reservations.includes(:facility).order(created_at: :desc) : []
  end

  def show
    @reservation = current_user.facilitity_reservations.includes(:facility).find(params[:id])
  end

  def destroy # 대관 신청 취소
    @reservation = current_user.facility_reservations.find(params[:id])
    @reservation.destroy
    redirect_to facility_reservations_path, notice: "대관 신청이 취소되었습니다."
  end

  private

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end

  def reservation_params
    params.require(:facility_reservation).permit(:reservation_date, :start_time, :end_time, :purpose, :headcount)
  end
end
