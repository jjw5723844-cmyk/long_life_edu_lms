class CourseRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :course

  # 수강 상태 감면 승인 상태 enum 정의
  enum :status, { pending: 0, confirmed: 1, cancelled: 2, refunded: 3 }, default: :pending
  # 감면 승인 상태 enum 정의
  enum :discount_status, { none_applied: 0, discount_requested: 1, discount_approved: 2 }, default: :none_applied

  # 동일 강좌 중복 신청 방지 모델 레벨 유효성 검증
  validates :user_id, uniqueness: { scope: :course_id, message: "이미 신청한 강좌입니다." }

  # 감면 검토 대기 대상 조회를 위한 scope
  scope :pending_discounts, -> { where(discount_status: :discount_requested) }
  # 수강 확정자 조회를 위한 scope
  scope :confirmed_students, -> { where(status: :confirmed) }
  # 대기자 순번 정렬 조회를 위한 scope
  scope :waitlisted_queue, -> { where(status: :waitlisted).order(waitlist_position: :asc) }

  # 총 결제 수입 집계 모델
  def self.total_revenue
    where(status: :confirmed).sum(:paid_amount)
  end

  # 수강 확정 완료 건수 집계 모델
  def self.confirmed_count
    where(status: :confirmed).count
  end

  # 대기 중인 수강신청 건수 집계 모델
  def self.pending_count
    where(status: :pending).count
  end

  # 환불 처리된 건수 집계 모델
  def self.refunded_count
    where(status: :refunded).count
  end

  # 감면 혜택 승인 완료 건수 집계 모델 메서드
  def self.total_discount_approved_count
    where(discount_status: :discount_approved).count
  end

  # 수강신청 데이터 CSV 변환 모델
  def self.to_csv
    headers = ["신청ID", "수강생명", "연락처", "강좌명", "신청상태", "감면상태", "결제금액", "신청일시"]

    CSV.generate(headers: true, col_sep: ",") do |csv|
      csv << headers
      includes(:user, :course).find_each do |reg|
        csv << [
          reg.id,
          reg.user&.name,
          reg.user&.phone,
          reg.course&.title,
          reg.status,
          reg.discount_status,
          reg.paid_amount,
          reg.created_at.strftime("%Y-%m-%d %H:%M:%S")
        ]
      end
    end
  end

  # 감면 혜택 승인 처리 모델
  def approve_discount!
    update!(discount_status: :discount_approved)
  end

  # 감면 혜택 반려 처리 모델
  def reject_discount!
    update!(discount_status: :discount_rejected)
  end

  # 평생교육법 시행령 제23조를 기준으로 하는 환불 산정 모델
  def calculate_refund_amount(cancellation_time = Time.current)
    return 0 if paid_amount.to_i.zero?
    return paid_amount unless course.respond_to?(:start_date) && course.start_date.present?

    start_date = course.start_date.to_date
    end_date = course.respond_to?(:end_date) && course.end_date.present? ? course.end_date.to_date : start_date + 1.month
    total_days = (end_date - start_date).to_i
    elapsed_days = (cancellation_time.to_date - start_date).to_i

    if cancellation_time.to_date < start_date
      paid_amount # 개강 전: 전액 반환
    elsif elapsed_days <= (total_days / 3.0)
      (paid_amount * 2 / 3.0).round # 총 수업시간의 1/3 경과 전: 2/3 반환
    elsif elapsed_days <= (total_days / 2.0)
      (paid_amount * 1 / 2.0).round # 총 수업시간의 1/2 경과 전: 1/2 반환
    else
      0 # 총 수업시간의 1/2 경과 후: 수업료를 반환하지 않는다.
    end
  end

  # 수강 취소 및 환불 실행/대기자 자동 승급 연동 모델
  def process_cancellation_add_refund!
    calculate_refund = calculate_refund_amount
    transaction do
      update!(
        status: calculate_refund.positive? ? :refunded : :cancelled,
        cancelled_at: Time.current,
        refund_amount: calculate_refund
      )
      promte_next_waitlisted_student!
    end
  end

  private

  # 취소 발생 시 최우선 대기자를 수강 확정으로 승급시키는 모델
  def promote_next_waitlisted_student!
    next_student = course.course_rgistrations.waitlisted_queue.first
    retrun unless next_student

    next_student.update!(status: :confirmed, waitlist_position: nil)
  end
end
