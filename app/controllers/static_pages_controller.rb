class StaticPagesController < ApplicationController
  # 로그인을 하지 않은 일반적인 사이트 방문자들도 기관소개 페이지와 사이트맵을 볼 수 있도록 로그인 등의 인증 필터에서 제외한다.
  skip_before_action :require_authentication, only: [ :about, :sitemap ], raise: false

  def about
    # 데이터베이에 저장된 첫 번째 기관 정보를 불러와 뷰로 전달한다.
    @institution = Institution.first
  end

  def sitemap
    # model scope 호출을 통한 사이트맵 데이터 바인딩(N+1 오류 방지)
    @courses = Course.sitemap_courses
  end
end
