class Institution < ApplicationRecord
  belongs_to :user

  # 강사 프로필 화면에서 해당 강사가 담당하는 강좌 목록(@instructor_profile.courses)을 User 모델을 통해 역추적할 수 있도록 연동
  has_many :course, through: :user
end
