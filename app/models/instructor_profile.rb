class InstructorProfile < ApplicationRecord
  # 회원 계정 및 담당 강좌, 강사료 정산 내역 관계 정의
  belongs_to :user
  has_many :courses, class_name: "Course", foreign_key: :user_id, primary_key: :user_id
  has_many :course, class_name: "Course", foreign_key: :user_id, primary_key: :user_id
  has_many :instructor_payrolls, dependent: :destroy

  # 강사 프로필 기본 정보 유효성을 검증
  validates :user_id, uniqueness: { message: "이미 강사 프로필이 존재합니다." }

  # 출강 강사 조회를 위한 scope
  scope :active_instructors, -> { joins(:user).where(user: { role: :teacher}) }

  # 뷰, 컨트롤러에서 호출하는 grade 메서드
  def grade
    read_attribute(:grade) || "일반"
  end

  # 강사의 평균 수강평점 산출 모델 메서드
  def average_rating
    reviews = CourseReview.where(course_id: course.select(:id))
    return 0.0 if reviews.empty?

    reviews.average(:rating).to_f.round(1)
  end

  # 시수당 기본 수당 단가 반환 모델
  def default_hourly_rate
    # hourly_rate 칼럼/메서드가 미정의된 상태여도 NameError/NoMethodError가 발생하지 않도록 respond_to? 및 send 사용
    if respond_to?(:hourly_rate) && send(:hourly_rate).present?
      send(:hourly_rate)
    else
      50_000
    end
  end

  # user 모델의 name, email_address 메서드를 위임받음
  # @instructor_profile.name 호출 시 @instructor_profile.user.name을 자동으로 반환
  delegate :name, :email_address, to: :user, allow_nil: true
end
