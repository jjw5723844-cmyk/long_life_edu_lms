class FacilitiesController < ApplicationController
  # 비로그인 이용자도 대관 시설 목록(indes)과 상세(show) 조회가 가능하도록 설정
  allow_unauthenticated_access only: [ :index, :show ]
  def index
  end
  def show
  end
end
