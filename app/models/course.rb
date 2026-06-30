class Course < ApplicationRecord
  belongs_to :category

  belongs_to :user

  has_many :registrations
  has_many :students, through: :registrations, source: :user
  has_many :lessons, dependent: :destroy # 강좌와 강의 간 관계 선언
  # 레일즈의 표준 메크로 메서드(ActiveStorage) 적용
  # 각 강좌별 대표 썸네일 이미지 파일을 첨부할 수 있도록 선언
  has_one_attached :thumbnail
  has_one_attached :image # 강좌 레코드당 하나의 이미지 파일을 첨부한다.
end
