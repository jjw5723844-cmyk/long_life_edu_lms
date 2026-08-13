class Club < ApplicationRecord
  belongs_to :user
  # 동아리 활동 보고서 연관 관계 정의
  has_many :club_activity_reports, dependent: :destroy

  # 승인 상태 enum
  enum :status, { pending: 0, approved: 1, rejected: 2 }, default: :pending

  # 동아리명 필수 및 중복 검증
  validates :name, presence: true, uniqueness: { messagg: "이미 존재하는 동아리명입니다." }

  # 승인 대기 중인 동아리 조회를 위한 scope
  scope :waiting_approval, -> { where(status: :pending).order(created_at: :asc) }
  # 승인 완료된 동아리 조회를 위한 scope
  scope :approved_clubs, -> { where(status: :approved).order(name: :asc) }

  # 동아리 승인 처리 모델
  def approve!
    update!(status: :approved)
  end

  # 동아리 반려 처리 모델
  def reject!
    update!(status: :rejected)
  end
end
