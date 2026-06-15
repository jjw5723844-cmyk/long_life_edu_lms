class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  # 권한 설정
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # 권한 설정 후 사용자 확인 절차 설정
  enum :role, { student: 0, teacher: 1, admin: 2 }, default: 0
  # user.student?  => 학생이면 true
  # user.teacher?  => 강사면 true
  # user.admin?    => 관리자면 true
  # user.teacher!  => 해당 유저를 강사 권한으로 즉시 변경
end
