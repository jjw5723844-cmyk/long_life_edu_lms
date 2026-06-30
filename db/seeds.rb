puts "==== 테스트 유저 데이터 생성 시작 ===="

# 잔여 데이터 정리(중복 방지)
Registration.destroy_all
Course.destroy_all
Category.destroy_all
User.destroy_all
Notice.destroy_all
Institution.destroy_all

# 강의 카테고리 생성
Default_category = Category.create!(name: "실용/취미교육")
puts "-> 기본 카테고리 생성 완료 (실용/취미교육)"

# 1. 학습자 계정
User.create!(
  email_address: "student@test.com",
  password: "password123",
  role: :student,
  name: "홍금보"
)
puts "-> 학생 계정 생성 완료 (student@test.com / password123)"

# 2. 강사 계정
User.create!(
  email_address: "teacher@test.com",
  password: "password456",
  role: :teacher,
  name: "오맹달"
)
puts "-> 강사 계정 생성 완료 (teacher@test.com / password456)"

# 3. 운영관리자 계정
User.create!(
  email_address: "admin@test.com",
  password: "password789",
  role: :admin,
  name: "주성치"
)
puts "-> 관리자 계정 생성 완료 (admin@test.com / password789)"

# 공지사항 실제 데이터 생성
Notice.create!([
  {
    title: "2026년도 하반기 평생학습 과정 수강신청 기간 및 방법 안내",
    content: "안녕하세요. 롱라이프 평생학습관입니다. 2026년도 하반기 수강신청은 6월 1일부터 공식 홈페이지를 통해 해당 강좌의 인원수에 따라 선착순으로 진행됩니다. 이용자분들의 많은 관심 바랍니다.",
    view_count: 437,
    is_pinned: true # 중요 공지 고정
  },
  {}
])

puts "==== 모든 테스트 데이터 생성 완료! ===="
