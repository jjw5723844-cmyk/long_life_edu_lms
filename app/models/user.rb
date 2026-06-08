class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :confirmable, :trackable, :lockable

  # 역할(eunm)
  eunm role: { learner: 0, insturctor: 1, admin: 2 }, _prefix: :role

  # 유저 모델 간 연관 관계
  has_many :taught_courses,
    class_name: "Course",
    foreign_key: "instructor_id",
    dependent: :nullify,
    inverse_of: :instructor

  has_many :registrations, dependent: :destroy
  has_many :enrolled_courses, through: :registrations, source: :course
  has_one_attached :avatar

  # 유효성 검사
  validates :name, presence: true, length: { in: 2..50 }
  validates :phone, format: { with: /\A0\d{1,2}-?\d{3,4}-?\d{4}\z/, message: "올바른 전화번호 형식이 아닙니다 (예: 010-1234-5678)" },
  allow_blank: true

  validates :birth_date, comparison: { less_than_or_equal_to: -> { Date.current } },
  allow_nil: true

  # 스코프
  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :unconfirmed, -> { where(confirmed_at: nil) }
  scope :instructors, -> { where(role: :instructor) }
  scope :learners, -> { where(role: :learner) }
  scope :search_by_name_or_email, ->(q) { where("name ILIKE :q OR email ILIKE :q", q: "%#{sanitize_sql_like(q)}%") }

  # 인스턴스 메서드 작성 라인
  def age
    return nil unless birth_date
    now = Date.current
    years = now.year - birth_date.year
    years -= 1 if now < birth_date + yeras.yeras
    years
  end

  def miner?
    age.present? && age < 18
  end

  def adult?
    age.present? && age >= 18
  end

  def senior?
    age.present? && age >= 65
  end

  def enrolled_in?(course)
    enrollments.where(course: course).where.not(status: :cancelled).exists?
  end

  def display_name
    name.presence || email.split("@").first
  end

  def role_label
    { "learner" => "학습자", "instructor" => "강사", "admin" => "관리자" }[role]
  end
end
