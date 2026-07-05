class InstructorsController < ApplicationController
  # 비회원 상태에서도 강사 목록을 탐색할 수 있도록 인증 필터 해제
  skip_before_action :require_authentication, only: [:index], raise: false
  def index
    # 권한은 강사인 유저만 출력되도록 한다.
    # 하지만 유저가 직접 웹에서 등록할 프로필과 강좌 데이터를 한번에 가져올 수 있도록 설정한다.
    @techers = User.where(role: :teacher)
                   .includes(:instructor_profile, :courses)
                   .order(name: :asc) # 강사의 이름을 기준으로 가나다순으로 정렬
  end
end
