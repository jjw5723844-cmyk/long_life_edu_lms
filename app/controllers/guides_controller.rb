class GuidesController < ApplicationController
  # 이용안내 비회원 등 불특정 다수의 인원도 자유롭게 볼 수 있도록 설정
  # 상위 보안 인증 필터 해제(raise: false로 오류 방지)
  allow_unauthenticated_access only: [ :index, :registration, :facility ], raise: false

  # 이용안내 메인 종합 허브(자주 묻는 질문, FAQ 등을 포함)
  def index
  end

  # 수강신청 프로세스 및 환불 규정 안내
  def registration
  end

  # 학습관 위치 및 시설 이용 안내
  def facility
  end
end
