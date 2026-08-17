class FacilityReservation < ApplicationRecord
  belongs_to :facility
  belongs_to :user

  # 대관 신청 상태 관리를 위한 enum 정의
  enum :status, { pending: 0, approved: 1, rejected: 2 }, default: :pending

  # 관리자 대시보드 표시용 승인 대기 목록 조회 scope
  scope :waiting_approval, -> { where(status: :pending).order(created_at: :asc) }

  # 대관 처리 완료 이력 조회 scope
  scope :processed_history, -> { where.not(status: :pending).order(updated_at: :desc) }
end
