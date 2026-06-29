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

  # 강사의 강좌 개설 권한 정의
  has_many :courses, dependent: :destroy
  # 학생의 수강신청 권한 정의
  has_many :registrations, dependent: :destroy
  # 등록 대장을 거쳐서 이용자가 최종적으로 수강 중인 강좌 내역 출력
  has_many :enrolled_courses, through: :registrations, source: :course
  # 진도율 트래킹(학습자별 개별 강의 수강 상태 기록)을 위한 User와 LessonProgress 간의 관계를 선언
  has_many :lesson_progresses, dependent: :destroy
end
