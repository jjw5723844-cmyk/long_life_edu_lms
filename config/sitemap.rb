# 사이트 기본 도메인 설정 (개발 환경: http://localhost:3000)
SitemapGenerator::Sitemap.default_host = "http://localhost:3000"
SitemapGenerator::Sitemap.compress = false # .xml.gz 대신 일반 .xml 파일로 생성

SitemapGenerator::Sitemap.create do
  # 0. 메인 페이지
  add root_path, priority: 1.0, changefreq: 'daily'

  # 1. 기관소개
  add about_path, priority: 0.7, changefreq: 'monthly'

  # 2. 공지사항
  add notices_path, priority: 0.8, changefreq: 'daily'
  if defined?(Notice)
    Notice.find_each do |notice|
      add notice_path(notice), lastmod: notice.updated_at, priority: 0.6, changefreq: 'weekly'
    end
  end

  # 3. 교육 과정 & 강사 소개
  add courses_path, priority: 0.9, changefreq: 'daily'
  add instructors_path, priority: 0.7, changefreq: 'monthly'

  # 카테고리별 페이지
  if defined?(Category)
    Category.find_each do |category|
      add category_path(category), lastmod: category.updated_at, priority: 0.8, changefreq: 'weekly'
    end
  end

  # 강좌 상세 페이지
  if defined?(Course)
    Course.find_each do |course|
      add course_path(course), lastmod: course.updated_at, priority: 0.9, changefreq: 'weekly'
    end
  end

  # 4. 이용안내 & 시설 대관
  add guides_path, priority: 0.6, changefreq: 'monthly'
  add registration_guides_path, priority: 0.6, changefreq: 'monthly'
  add facility_guides_path, priority: 0.6, changefreq: 'monthly'
  add facilities_path, priority: 0.7, changefreq: 'weekly'

  # 시설 상세 페이지
  if defined?(Facility)
    Facility.find_each do |facility|
      add facility_path(facility), lastmod: facility.updated_at, priority: 0.6, changefreq: 'monthly'
    end
  end

  # 5. 학습동아리
  add clubs_path, priority: 0.7, changefreq: 'weekly'
  add gallery_clubs_path, priority: 0.6, changefreq: 'weekly'

  # 동아리 상세 페이지
  if defined?(Club)
    Club.find_each do |club|
      add club_path(club), lastmod: club.updated_at, priority: 0.6, changefreq: 'weekly'
    end
  end
end
