puts "==== 테스트 유저 데이터 생성 시작 ===="

# 잔여 데이터 정리
Registration.destroy_all
Course.destroy_all
Category.destroy_all
User.destroy_all

# 카테고리 생성
default_category = Category.create!(name: "실용/취미교육")
puts "-> 기본 카테고리 생성 완료 (실용/취미교육)"

# 학생 계정
User.create!(
  email_address: "student@test.com",
  password: "password123",
  role: :student,
  name: "홍금보 학생"
)
puts "-> 학생 계정 생성 완료 (student@test.com / password123)"

# 강사 계정
User.create!(
  email_address: "teacher@test.com",
  password: "password456",
  role: :teacher,
  name: "오맹달 강사"
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

puts "==== 모든 테스트 데이터 생성 완료! ===="
