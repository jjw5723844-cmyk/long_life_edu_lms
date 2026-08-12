class InstructorPayroll < ApplicationRecord
  # 강사 프로필 및 대상 강좌 관계 정의
  belongs_to :instructor_profile
  belongs_to :course

  # 강사료 정산 지급 상태 enum 정의 (0: 미지급, 1: 지급완료)
  enum :status, { unpaid: 0, processed: 1 }, default: :unpaid

  # 미지급 항목 조회 scope
  scope :unpaid_list, -> { where(status: :unpaid) }
  # 지급 완료 항목 조회 scope
  scope :processed_list, -> { where(status: :processed) }

  # 강의 시수 및 강사 단가 기반 강사료 자동 산출 모델
  def calculate_amount!
    rate = instructor_profile.default_hourly_rate
    hours = teaching_hours.to_i
    self.calculate_amount = hours * rate
    save!
  end

  # 강사료 지급 확정 처리 모델
  def process_payment!
    update!(status: :processed)
  end
end
