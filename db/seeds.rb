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
  }
])

# 기관소개 실제 데이터 생성
Institution.create!([
  {
    name: "롱라이프 평생학습관",
    greeting_title: "원장 인사말",
    greeting_content: "안녕하세요. 롱라이프 평생학습관에 오신 것을 환영합니다. 저희 기관은 다양한 평생학습 프로그램을 통해 지역사회 구성원들의 자기계발과 삶의 질 향상을 위해 최선을 다하고 있습니다. 여러분의 많은 참여와 관심 부탁드립니다.",
    mission: "롱라이프 평생학습관은 지역사회 구성원들의 자기계발과 삶의 질 향상을 위해 다양한 평생학습 프로그램을 제공하고, 학습자 중심의 교육 환경을 조성하여 지속적인 학습 문화를 확산시키는 것을 목표로 합니다.",
    core_values: "1. 학습자 중심: 학습자의 필요와 관심을 최우선으로 고려한 교육 프로그램 제공\n2. 평생학습 문화 확산: 지역사회 구성원들이 지속적으로 학습할 수 있는 환경 조성\n3. 다양성과 포용성: 다양한 배경과 경험을 가진 학습자들을 위한 포용적인 교육 환경 제공\n4. 혁신과 창의성: 새로운 교육 방법과 기술을 도입하여 창의적이고 혁신적인 학습 경험 제공\n5. 지역사회 기여: 지역사회 발전과 구성원들의 삶의 질 향상에 기여하는 교육 기관으로서의 역할 수행"
  }
])

puts "==== 모든 테스트 데이터 생성 완료! ===="
