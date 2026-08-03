class InstructorProfile < ApplicationRecord
  belongs_to :user

  # user 모델의 name, email_address 메서드를 위임받음
  # @instructor_profile.name 호출 시 @instructor_profile.user.name을 자동으로 반환
  delegate :name, :email_address, to: :user, allow_nil: true
end
