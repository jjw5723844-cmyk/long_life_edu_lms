class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  # 1. 권한 설정
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # 권한 설정 후 사용자 확인 절차 설정
  enum :role, { student: 0, teacher: 1, admin: 2 }, default: 0
  # user.student?  => 학생이면 true
  # user.teacher?  => 강사면 true
  # user.admin?    => 관리자면 true
  # user.teacher!  => 해당 유저를 강사 권한으로 즉시 변경

  # 2. 강사의 강좌 개설 권한 정의
  has_many :courses, dependent: :destroy
  # 학생의 수강신청 권한 정의
  has_many :registrations, dependent: :destroy
  # 등록 대장을 거쳐서 이용자가 최종적으로 수강 중인 강좌 내역 출력
  has_many :enrolled_courses, through: :registrations, source: :course
  # 진도율 트래킹(학습자별 개별 강의 수강 상태 기록)을 위한 User와 LessonProgress 간의 관계를 선언
  has_many :lesson_progresses, dependent: :destroy

  # 3. 강사 프로필 설정
  has_one :instructor_profile, dependent: :destroy
  # 강사 프로필의 필드를 유저 모델에서 직접 접근할 수 있도록 설정
  delegate :specialty, :bio, to: :instructor_profile, allow_nil: true

  # 평생학습관의 LMS 수강 강좌 정렬 및 N+1 오류 방지
  def ordered_enrolled_courses
    enrolled_courses.includs(:category, :registrations, :user).references(:registrations).order("registrations.created_at DESC")
  end

  # 평생학습관의 학습자 식별 회원번호 포맷팅 로직
  def member_code
    "M-#{created_at&.strftime('%Y') || Time.zone.now.year}#{id.to_s.rjust(5, '0')}"
  end

  # 평생학습관의 교육 분기(상/하반기) 명칭 산출
  def current_learning_term
    now = Time.zone.now.to_date
    now.month >= 7 ? "#{now.year}년 하반기 교육과정" : "#{now.year}년 상반기 교육과정"
  end

  # 평생학습관 학습 기수별 진행률 산출
  def learning_term_progress_percentage
    now = Time.zone.now.to_date
    start_date = now.month >= 7 ? Date.new(now.year, 7, 1) : Date.new(now.year, 1, 1)
    end_date = now.month >= 7 ? Date.new(now.year, 12, 31) : Date.new(now.year, 6, 30)

    total_days = (end_date - start_date).to_f
    elapsed_days = (now - start_date).to_f

    return 0.0 if total_days <= 0 || elapsed_days < 0
    return 100.0 if elapsed_days > total_days

    ((elapsed_days / total_days) * 100).round(1)
  end
end
