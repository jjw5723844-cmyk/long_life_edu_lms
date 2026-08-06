class Course < ApplicationRecord
  # optional: true를 적용하여 연관 데이터가 없어도 에러가 발생하지 않도록 보호 관계를 선언
  belongs_to :category, optional: true
  belongs_to :user, optional: true

  # 라우트와 컨트롤러에서 구현한 수강 후기 기능이 안전하게 작동하고,
  # 강좌 삭제 시 강좌에 해당하는 관련 후기도 함께 지워지도록 설정
  has_many :course_reviews, dependent: :destroy
  has_many :registrations
  has_many :students, through: :registrations, source: :user
  has_many :lessons, dependent: :destroy # 강좌와 강의 간 관계 선언

  # 강좌 객체에서 담당 강사의 프로필 정보(@course.instructor_profile)를 User 모델을 거쳐 바로 조회할 수 있도록 연동
  has_one :instructor_profile, through: :user

  # 레일즈의 표준 메크로 메서드(ActiveStorage) 적용
  # 각 강좌별 대표 썸네일 이미지 파일을 첨부할 수 있도록 선언
  has_one_attached :thumbnail
  has_one_attached :image # 강좌 레코드당 하나의 이미지 파일을 첨부한다.

  # 카테고리 필터링을 위한 스코프 적용
  scope :by_category, ->(cat) {
    if cat.present?
      joins(:category).where(categories: {name: cat})
    else
      all
    end
  }

  # 사이트맵 조회 시 N+1 쿼리 오류 방지 및 데이터 연결을 위한 전용 스코프 설정
  scope :sitemap_courses, -> {includes(:user, :instructor_profile)}

  # 강사 이름을 안전하게 가져오는 대표 메서드
  def display_instructor_name
    instructor_profile&.name.presence || instructor_name.presence || user&.name || "담당 강사"
  end
end
