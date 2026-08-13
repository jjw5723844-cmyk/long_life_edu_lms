class ClubActivityReport < ApplicationRecord
  belongs_to :club

  # 검토 상태 Enum 정의 (0: 제출됨, 1: 검토완료)
  enum :status, { submitted: 0, reviewed: 1 }, default: :submitted

  # 필수 항목 유효성 검증
  validates :title, :activity_date, :content, presence: true

  # 검토 대기 보고서 조회를 위한 scope
  scope :pending_reviews, -> { where(status: :submitted).order(activity_date: :desc) }

  # 활동 보고서 검토 완료 처리 모델
  def review!
    update!(status: :reviewed)
  end
end
