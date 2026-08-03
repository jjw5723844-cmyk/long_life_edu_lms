puts "==== 테스트 유저 데이터 생성 시작 ===="

# 잔여 데이터 정리(중복 방지)
Registration.destroy_all rescue nil
Course.destroy_all rescue nil
InstructorProfile.destroy_all rescue nil
Notice.destroy_all rescue nil
Institution.destroy_all rescue nil
User.destroy_all rescue nil
Category.destroy_all rescue nil

# 강의 카테고리 생성
default_category = Category.create!(name: "실용/취미교육")
puts "-> 기본 카테고리 생성 완료 (실용/취미교육)"

# 1. 학습자 계정
User.create!(
  email_address: "student@test.com",
  password: "password123",
  role: :student,
  name: "홍금보"
)
puts "-> 학생 계정 생성 완료 (student@test.com / password123)"

# 2. 강사 계정 (오맹달)
teacher_user = User.create!(
  email_address: "teacher@test.com",
  password: "password456",
  role: :teacher,
  name: "오맹달"
)

InstructorProfile.create!(
  user: teacher_user,
  specialty: "문화/취미 예술 전문",
  bio: "오맹달 강사는 다양한 문화와 취미 예술 분야에서 풍부한 경험을 가지고 있으며, 학습자들에게 창의적이고 실용적인 교육을 제공하는 것을 목표로 합니다."
)
puts "-> 강사 계정 및 프로필 생성 완료 (오맹달 강사)"

# 3. 천마이클잭슨 강사 계정, 프로필 및 강좌
cheon_user = User.create!(
  email_address: "michael@test.com",
  password: "password123",
  role: :teacher,
  name: "천마이클잭슨"
)

InstructorProfile.create!(
  user: cheon_user,
  specialty: "80-90 팝송 및 보컬 트레이닝",
  bio: "80-90년대 레트로 팝송과 발성을 쉽고 재미있게 지도하는 20년 경력의 보컬 트레이너입니다."
)

Course.create!(
  title: "80-90 추억의 팝송 여행",
  description: "40대 이상 성인을 위한 레트로 팝송과 함께하는 추억 여행 강좌입니다.",
  category: default_category,
  user: cheon_user,
  instructor_name: "천마이클잭슨",
  max_students: 30
)
puts "-> 강사 및 강좌 생성 완료 (천마이클잭슨 / 80-90 추억의 팝송 여행)"

# 4. 운영관리자 계정
User.create!(
  email_address: "admin@test.com",
  password: "password789",
  role: :admin,
  name: "주성치"
)
puts "-> 관리자 계정 생성 완료 (admin@test.com / password789)"

# 🚨🚨🚨 5개 분야별 강사 및 강좌 데이터 안전 생성 🚨🚨🚨
categories_data = [
  {
    category_name: "인문/교양",
    instructors: [
      { 
        name: "김철수", email: "kim.humanities@test.com", specialty: "동양철학 및 고전 강독", bio: "삶의 지혜를 전하는 동양고전 전문 강사입니다. 논어와 도덕경을 통해 현대인의 마음 치유를 돕습니다.",
        course_title: "마음으로 읽는 논어와 동양철학", course_desc: "어려운 동양고전을 현대적 관점에서 쉽고 재미있게 풀어나가는 인문학 강좌입니다."
      },
      { 
        name: "이지혜", email: "lee.history@test.com", specialty: "세계 역사 및 서양 미술사", bio: "세계사와 미술사를 융합하여 흥미진진한 인문학 여행 이야기로 풀어내는 역사 스토리텔러입니다.",
        course_title: "명화와 함께 떠나는 서양 미술사 여행", course_desc: "루브르부터 오르세까지 대표적인 명화 속에 숨겨진 역사와 이야기들을 탐구합니다."
      }
    ]
  },
  {
    category_name: "IT/디지털",
    instructors: [
      { 
        name: "박성민", email: "park.it@test.com", specialty: "스마트폰 활용 및 생성형 AI 기초", bio: "디지털 소외 없는 평생학습을 위해 시니어 맞춤형 스마트폰 및 AI 활용법을 친절히 안내합니다.",
        course_title: "스마트폰 입문과 ChatGPT 실습", course_desc: "실생활에 유용한 스마트폰 앱 활용법과 AI 인공지능 기초를 함께 배우는 실습 과정입니다."
      },
      { 
        name: "최유진", email: "choi.coding@test.com", specialty: "파이썬 프로그래밍 & 웹 기초", bio: "비전공자도 쉽게 배우는 컴퓨팅 사고력과 생활 속 코딩 프로젝트를 지도하는 IT 전문 교육자입니다.",
        course_title: "비전공자를 위한 쉽게 배우는 파이썬", course_desc: "복잡한 이론 없이 기초 문법부터 실생활 자동화 프로그램까지 만드는 코딩 입문 과정입니다."
      }
    ]
  },
  {
    category_name: "문화/예술",
    instructors: [
      { 
        name: "정다은", email: "jung.art@test.com", specialty: "수묵 캘리그라피 & 감성 손글씨", bio: "먹향과 함께 마음을 담아내는 수묵 캘리그라피를 통해 나만의 일상 예술 작품을 함께 만듭니다.",
        course_title: "감성을 담은 힐링 수묵 캘리그라피", course_desc: "기초 선 긋기부터 엽서, 캘린더 제작까지 나만의 예쁜 손글씨와 수묵화를 만드는 강좌입니다."
      },
      { 
        name: "강민우", email: "kang.drawing@test.com", specialty: "태블릿 디지털 드로잉", bio: "아이패드 및 디지털 기기를 활용해 일상의 소중한 순간과 캐릭터를 그리는 일러스트 강사입니다.",
        course_title: "태블릿으로 그리는 일상 디지털 드로잉", course_desc: "디지털 기기를 활용해 소중한 일상 풍경과 인물을 담아내는 캐릭터 일러스트 클래스입니다."
      }
    ]
  },
  {
    category_name: "언어/어학",
    instructors: [
      { 
        name: "한지원", email: "han.english@test.com", specialty: "여행 원어민 생활 영어 회화", bio: "부담 없이 따라 하는 패턴 영어로 해외여행에서 바로 쓰는 실전 회화 중심 강의를 제공합니다.",
        course_title: "바로 써먹는 해외여행 실전 영어", course_desc: "공항, 호텔, 식당 등 해외여행 주요 상황에서 자신 있게 말할 수 있는 필수 패턴 회화입니다."
      },
      { 
        name: "원혜진", email: "won.spanish@test.com", specialty: "시니어 기초 스페인어 & 문화", bio: "스페인 및 중남미 문화와 함께 익히는 다채롭고 쉬운 입문 스페인어 강좌를 운영합니다.",
        course_title: "문화와 함께 배우는 첫걸음 스페인어", course_desc: "열정의 나라 스페인의 풍성한 문화와 기초 인삿말, 발음을 즐겁게 익히는 기초 어학 강좌입니다."
      }
    ]
  },
  {
    category_name: "시민/교양",
    instructors: [
      { 
        name: "송태식", email: "song.citizen@test.com", specialty: "생활 법률 상식 & 부동산 실무", bio: "알아두면 유익한 상속, 계약, 금융 등 시민들을 위한 일상 생활 법률 길잡이 역할을 합니다.",
        course_title: "알아두면 돈이 되는 생활 법률 상식", course_desc: "부동산 임대차, 상속, 증여, 계약서 작성법 등 일상에서 꼭 알아야 할 생활 필수 법률을 배웁니다."
      },
      { 
        name: "윤서영", email: "yoon.eco@test.com", specialty: "친환경 에코 라이프 & 제로웨이스트", bio: "지속 가능한 지구를 위해 생활 속 자원순환과 친환경 살림법을 공유하는 환경 교육 전문가입니다.",
        course_title: "지구를 지키는 친환경습 강좌입니다 에코 라이프", course_desc: "생활 속 쓰레기 줄이기(Zero-Waste)와 친환경 DIY 제품 제작을 직접 체험해 보는 실습 강좌입니다."
      }
    ]
  }
]

categories_data.each do |cat_hash|
  cat = Category.find_or_create_by!(name: cat_hash[:category_name])

  cat_hash[:instructors].each do |inst|
    begin
      u = User.create!(
        email_address: inst[:email],
        password: "password123",
        role: :teacher,
        name: inst[:name]
      )
      InstructorProfile.create!(
        user: u,
        specialty: inst[:specialty],
        bio: inst[:bio]
      )
      Course.create!(
        title: inst[:course_title],
        description: inst[:course_desc],
        category: cat,
        user: u,
        instructor_name: inst[:name],
        max_students: 20
      )
      puts "  └─ [#{cat.name}] #{inst[:name]} 강사 및 강좌 생성 성공"
    rescue => e
      puts "  ❌ [생성 실패] #{inst[:name]} 강사 생성 중 오류 발생: #{e.message}"
    end
  end
end

# 공지사항 실제 데이터 생성
Notice.create!([
  {
    title: "2026년도 하반기 평생학습 과정 수강신청 기간 및 방법 안내",
    content: "안녕하세요. 롱라이프 평생학습관입니다. 2026년도 하반기 수강신청은 6월 1일부터 공식 홈페이지를 통해 해당 강좌의 인원수에 따라 선착순으로 진행됩니다. 이용자분들의 많은 관심 바랍니다.",
    view_count: 437,
    is_pinned: true
  }
]) rescue nil

# 기관소개 실제 데이터 생성
Institution.create!([
  {
    name: "롱라이프 평생학습관",
    greeting_title: "원장 인사말",
    greeting_content: "안녕하세요. 롱라이프 평생학습관에 오신 것을 환영합니다. 저희 기관은 다양한 평생학습 프로그램을 통해 지역사회 구성원들의 자기계발과 삶의 질 향상을 위해 최선을 다하고 있습니다. 여러분의 많은 참여와 관심 부탁드립니다.",
    mission: "롱라이프 평생학습관은 지역사회 구성원들의 자기계발과 삶의 질 향상을 위해 다양한 평생학습 프로그램을 제공하고, 학습자 중심의 교육 환경을 조성하여 지속적인 학습 문화를 확산시키는 것을 목표로 합니다.",
    core_values: "1. 학습자 중심: 학습자의 필요와 관심을 최우선으로 고려한 교육 프로그램 제공\n2. 평생학습 문화 확산: 지역사회 구성원들이 지속적으로 학습할 수 있는 환경 조성\n3. 다양성과 포용성: 다양한 배경과 경험을 가진 학습자들을 위한 포용적인 교육 환경 제공\n4. 혁신과 창의성: 새로운 교육 방법과 기술을 도입하여 창의적이고 혁신적인 학습 경험 제공\n5. 지역사회 기여: 지역사회 발전과 구성원들의 삶의 질 향상에 기여하는 교육 기관으로서의 역할 수행"
  }
]) rescue nil

puts "==== 모든 테스트 데이터 생성 완료! ===="