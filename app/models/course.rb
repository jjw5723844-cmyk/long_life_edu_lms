class Course < ApplicationRecord
  belongs_to :category
  belongs_to :user

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
end
