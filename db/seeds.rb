puts "==== 테스트 유저 데이터 생성 시작 ===="

# 외래키 제약조건 오류를 방지하기 위해 자식 테이블부터 부모 테이블 순으로 삭제 순서 정리
LessonProgress.destroy_all rescue nil # 레슨 진행률 데이터 삭제
Lesson.destroy_all rescue nil # [추가됨]: 레슨 데이터 삭제
CourseRegistration.destroy_all rescue nil # 수강신청 데이터 삭제
CourseReview.destroy_all rescue nil # 수강후기 데이터 삭제
InstructorPayroll.destroy_all rescue nil # 강사 수당 데이터 삭제
FacilityReservation.destroy_all rescue nil # 시설 예약 데이터 삭제
Facility.destroy_all rescue nil # 시설 데이터 삭제
ClubActivityReport.destroy_all rescue nil # 동아리 보고서 삭제
LearningClub.destroy_all rescue nil # 학습동아리 데이터 삭제
ClubActivity.destroy_all rescue nil # 동아리 활동 데이터 삭제
Club.destroy_all rescue nil # 동아리 데이터 삭제
Registration.destroy_all rescue nil
Course.destroy_all rescue nil
InstructorProfile.destroy_all rescue nil
Session.destroy_all rescue nil # 세션 데이터 삭제 (User 삭제 시 외래키 충돌 방지)
Notice.destroy_all rescue nil
Institution.destroy_all rescue nil
User.destroy_all rescue nil
Category.destroy_all rescue nil

# 강의 카테고리 생성
default_category = Category.find_or_create_by!(name: "실용/취미교육") # [수정됨]: 중복 생성 방지를 위해 find_or_create_by! 사용
puts "-> 기본 카테고리 생성 완료 (실용/취미교육)"

# 1. 학습자 계정
student_user = User.find_or_initialize_by(email_address: "student@test.com") # [수정됨]: 이메일 기준 기존 유저 조회 또는 초기화
student_user.update!(
  password: "password123",
  role: :student,
  name: "홍금보"
)
puts "-> 학생 계정 생성 완료 (student@test.com / password123)"

# 2. 강사 계정 (오맹달)
teacher_user = User.find_or_initialize_by(email_address: "teacher@test.com") # [수정됨]: 이메일 기준 기존 유저 조회 또는 초기화
teacher_user.update!(
  password: "password456",
  role: :teacher,
  name: "오맹달"
)

inst_prof1 = InstructorProfile.find_or_initialize_by(user: teacher_user) # [수정됨]: 기존 프로필 조회 또는 초기화
inst_prof1.update!(
  specialty: "문화/취미 예술 전문",
  bio: "오맹달 강사는 다양한 문화와 취미 예술 분야에서 풍부한 경험을 가지고 있으며, 학습자들에게 창의적이고 실용적인 교육을 제공하는 것을 목표로 합니다."
)
puts "-> 강사 계정 및 프로필 생성 완료 (오맹달 강사)"

# 3. 천마이클잭슨 강사 계정, 프로필 및 강좌
cheon_user = User.find_or_initialize_by(email_address: "michael@test.com") # [수정됨]: 이메일 기준 기존 유저 조회 또는 초기화
cheon_user.update!(
  password: "password123",
  role: :teacher,
  name: "천마이클잭슨"
)

inst_prof2 = InstructorProfile.find_or_initialize_by(user: cheon_user) # [수정됨]: 기존 프로필 조회 또는 초기화
inst_prof2.update!(
  specialty: "80-90 팝송 및 보컬 트레이닝",
  bio: "80-90년대 레트로 팝송과 발성을 쉽고 재미있게 지도하는 20년 경력의 보컬 트레이너입니다."
)

cheon_course = Course.find_or_initialize_by(title: "80-90 추억의 팝송 여행") # [수정됨]: 기존 강좌 조회 또는 초기화
cheon_course.update!(
  description: "40대 이상 성인을 위한 레트로 팝송과 함께하는 추억 여행 강좌입니다.",
  category: default_category,
  user: cheon_user,
  instructor_name: "천마이클잭슨",
  max_students: 30
)
puts "-> 강사 및 강좌 생성 완료 (천마이클잭슨 / 80-90 추억의 팝송 여행)"

# 4. 운영관리자 계정
admin_user = User.find_or_initialize_by(email_address: "admin@test.com") # [수정됨]: 이메일 기준 기존 유저 조회 또는 초기화
admin_user.update!(
  password: "password789",
  role: :admin,
  name: "주성치"
)
puts "-> 관리자 계정 생성 완료 (admin@test.com / password789)"

# 5개 분야별 강사 및 강좌 테스트 데이터 생성
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
      u = User.find_or_initialize_by(email_address: inst[:email])
      u.update!(
        password: "password123",
        role: :teacher,
        name: inst[:name]
      )

      prof = InstructorProfile.find_or_initialize_by(user: u)
      prof.update!(
        specialty: inst[:specialty],
        bio: inst[:bio]
      )

      crs = Course.find_or_initialize_by(title: inst[:course_title])
      crs.update!(
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

# 공지사항 실제 데이터 생성(6개)
notices_data = [
  {
    title: "2026년도 하반기 평생학습 과정 수강신청 기간 및 방법 안내",
    content: <<~TEXT,
          안녕하세요, 롱라이프 평생학습관입니다.
          2026년도 하반기 수강신청 일정을 아래와 같이 안내해 드립니다. 시민 여러분의 많은 관심과 참여 바랍니다.

          📌 수강신청 일정
          - 신청 기간: 2026년 8월 10일(월) 09:00 ~ 8월 24일(월) 18:00
          - 신청 방법: 롱라이프 평생학습관 홈페이지 및 1층 학습관 종합 지원실 현장 접수

          🎯 모집 대상 및 혜택
          - 수강 대상: 관내 주민 및 평생학습에 관심 있는 시민 누구나
          - 수강료: 강좌별 상이(국가유공자, 기초생활수급자 50% 감면)

          ⚠️ 유의사항
          ※ 인기 강좌의 경우 조기 마갑될 수 있으니 미리 회원가입 후 신청해 주시기 바랍니다.
          ※ 현장 접수 및 수강증 발급 문의는 1층 학습관 종합 지원실을 방문해 주세요.
    TEXT
    view_count: 439,
    is_pinned: true
  },
  {
    title: "[모집안내] 2026년 여름학기 디지털 배움터 1:1 맞춤형 교육 수강생 모집",
    content: <<~TEXT,
          스마트폰 기본 조작부터 AI(ChatGPT) 활용까지!
          1:1로 친절하게 안내해 드리는 '디지털 배움터' 수강생을 모집합니다.

          🗓️ 교육 기간: 2026. 08. 18 ~ 09. 25(매주 화, 목)
          📍 교육 장소: 3층 스마트 정보화 배움터 (디지털 데스크톱 30대 구비)
          👥 모집 인원: 선착순 15명
          📞 신청 문의: 1층 학습관 종합 지원실(032-1234-5678)
    TEXT
    view_count: 128,
    is_pinned: false
  },
  {
    title: "[행사/소식] 평생학습관 개관 5주년 기념 '지역 주민 힐링 콘서트' 개최",
    content: <<~TEXT,
          롱라이프 평생학습관 개관 5주년을 맞아 지역 주민분들과 함께하는 뜻깊은 음악회를 마련했습니다.

          📅 일시: 2026년 8월 29일(토) 15:00
          🏟️ 장소: 1층 튼튼 북카페 라운지 (개방형 무대)
          🎶 출련: 수강생 오케스트라 동아리 & 초청 가곡 공연
          🎟️ 관람료: 전석 무료 (당일 선착순 입장)
    TEXT
    view_count: 254,
    is_pinned: false
  },
  {
    title: "[시설/대관] 8월 중 세미나실 및 다목적 강의실 무료 대관 신청 안내",
    content: <<~TEXT,
          지역 학습 동아리 및 정기 모임을 위한 평생학습관 8월 대관 신청을 받습니다.

          (1) 신청 대상: 5인 이상으로 구성된 관내 학습 동아리
          (2) 대관 신청: 2층 다목적 세미나실, 2층 다목적 강의실 (A/B/C)
          (3) 접수 방법: [이용안내] -> [시설 대관 신청] 메뉴 또는 1층 학습관 종합 지원실 방문 접수

          💡 깨끗하고 쾌적한 시설 이용을 위해 대관 수칙을 준수해 주시길 바랍니다.
    TEXT
    view_count: 89,
    is_pinned: false
  },
  {
    title: "[행사/소삭] 2026 시민 인문학 특강: 'AI 시대, 인간의 지혜를 묻다'",
    content: <<~TEXT,
          급변하는 인공지능 시대에 삶의 가치와 철학을 돌아보는 2026 시민 인문학 특강이 개설됩니다.

          🎤 강사: 김철수 교수 (동양철학/인문학 전문)
          🗓️ 일시: 2026년 9월 3일(목) 19:00 ~ 21:00
          📍 장소: 2층 다목적 세미나실
          💵 수강료: 무료
          📝 사전 접수: [교육 과정] 메뉴에서 신청 가능합니다.
    TEXT
    view_count: 312,
    is_pinned: false
  },
  {
    title: "[모집안내] 시니어 맞춤형 실용 영어회화 주말반 추가 수강생 모집",
    content: <<~TEXT,
          해외여행 및 일상생활에서 유용하게 쓰이는 필수 여행 영어회화 클래스 주말반 인원을 추가 모집합니다.

          ⏰ 강의 시간: 매주 토요일 10:00 ~ 12:00 (총 8주)
          📍 강의 장소: 2층 다목적 강의실
          👩‍🏫 담당 강사: 한지원 강사
          📚 교재: 자체 제작 프린트 무료 제공
          📞 문의: 1층 학습관 종합 지원실
    TEXT
    view_count: 175,
    is_pinned: false
  }
]

notices_data.each do |n|
  Notice.find_or_create_by!(title: n[:title]) do |notice|
    notice.content = n[:content]
    notice.view_count = n[:view_count]
    notice.is_pinned = n[:is_pinned]
  end
end
puts "~> 공지사항 데이터 생성 완료"

# 기관소개 실제 데이터 생성
Institution.find_or_create_by!(name: "롱라이프 평생학습관") do |inst|
  inst.greeting_title = "원장 인사말"
  inst.greeting_content = "안녕하세요. 롱라이프 평생학습관에 오신 것을 환영합니다. 저희 기관은 다양한 평생학습 프로그램을 통해 지역사회 구성원들의 자기계발과 삶의 질 향상을 위해 최선을 다하고 있습니다. 여러분의 많은 참여와 관심 부탁드립니다."
  inst.mission = "롱라이프 평생학습관은 지역사회 구성원들의 자기계발과 삶의 질 향상을 위해 다양한 평생학습 프로그램을 제공하고, 학습자 중심의 교육 환경을 조성하여 지속적인 학습 문화를 확산시키는 것을 목표로 합니다."
  inst.core_values = "1. 학습자 중심: 학습자의 필요와 관심을 최우선으로 고려한 교육 프로그램 제공\n2. 평생학습 문화 확산: 지역사회 구성원들이 지속적으로 학습할 수 있는 환경 조성\n3. 다양성과 포용성: 다양한 배경과 경험을 가진 학습자들을 위한 포용적인 교육 환경 제공\n4. 혁신과 창의성: 새로운 교육 방법과 기술을 도입하여 창의적이고 혁신적인 학습 경험 제공\n5. 지역사회 기여: 지역사회 발전과 구성원들의 삶의 질 향상에 기여하는 교육 기관으로서의 역할 수행" # [수정됨]: 핵심 가치
end rescue nil

# 통합 검증 데이터 구축 

# 1. 수강신청 테스트 데이터
begin
  student_user = User.find_by(email_address: "student@test.com")
  sample_course = Course.first

  if student_user && sample_course
    reg = CourseRegistration.find_or_initialize_by(user: student_user, course: sample_course)
    reg.update!(
      status: 1,
      discount_status: 0,
      paid_amount: 30000
    )
    puts "-> 수강신청 테스트 데이터 생성 완료"
  end
rescue => e
  puts "  ❌ 수강신청 데이터 생성 실패: #{e.message}"
end

# 2. 강사 정산 테스트 데이터 생성
begin
  teacher_inst = InstructorProfile.first
  sample_course = Course.first

  if teacher_inst && sample_course
    pay = InstructorPayroll.find_or_initialize_by(instructor_profile: teacher_inst, course: sample_course, target_month: "2026-08")
    pay.update!(
      teaching_hours: 15,
      calculated_amount: 750000,
      status: 0
    )
    puts "-> 강사 정산 테스트 데이터 생성 완료"
  end
rescue => e
  puts "  ❌ 강사 정산 데이터 생성 실패: #{e.message}"
end

# 3. 학습 동아리 및 활동 내역 테스트
begin
  student_user = User.find_by(email_address: "student@test.com")

  if student_user
    test_club = Club.find_or_initialize_by(name: "롱라이프 인문학 독서회")
    test_club.update!(
      user: student_user,
      category: "인문/교양",
      description: "매주 고전을 읽고 토론하는 시민 동아리입니다.",
      leader_name: student_user.name,
      current_members: 6,
      max_members: 12,
      status: "approved"
    )

    # 동아리 활동 중복 생성 방지
    act = ClubActivity.find_or_initialize_by(club: test_club, title: "8월 정기 독서 토론회")
    act.update!(
      content: "논어 1장 독해 및 자유 토론 진행",
      activity_date: Date.current
    )
    puts "-> 학습 동아리 및 활동 내역 생성 완료"
  end
rescue => e
  puts "  ❌ 학습 동아리 데이터 생성 실패: #{e.message}"
end

# 4. 시설 및 대관 예약 테스트 데이터
begin
  fac = Facility.find_or_initialize_by(name: "제1세미나실")
  fac.update!(
    location: "평생학습관 2층",
    capacity: 30,
    fee: 20000,
    description: "빔프로젝터 및 마이크 음향 시설 구비",
    status: "available"
  )

  student_user = User.find_by(email_address: "student@test.com")

  if student_user

    res = FacilityReservation.find_or_initialize_by(facility: fac, user: student_user, reservation_date: Date.tomorrow)
    res.update!(
      start_time: "14:00",
      end_time: "16:00",
      purpose: "동아리 정기 모임",
      headcount: 8,
      status: "pending"
    )
    puts "-> 시설 및 대관 예약 데이터 생성 완료"
  end
rescue => e
  puts "  ❌ 시설 대관 데이터 생성 실패: #{e.message}"
end

puts "==== 모든 테스트 데이터 생성 완료! ===="