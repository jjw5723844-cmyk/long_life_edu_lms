class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern
  stale_when_importmap_changes

  private

  # 1. 로그인 여부 확인 및 이동 경로 기억
  def require_login
    unless current_user
      session["forwarding_url"] = request.original_url if request.get?
      redirect_to new_session_path, alert: "로그인이 필요한 서비스입니다."
    end
  end

  # 2. 강사, 관리자 확인(전제 조건: 로그인이 되어있어야 한다.)
  def require_teacher_or_admin
    unless current_user && (current_user.teacher? || current_user.admin?) # 권한을 가진 유저가 강사인가? 관리자인가? 확인
      redirect_to root_path, alert: "강좌 개설 권한이 없습니다. 강사 또는 관리자 계정으로 로그인해 주세요."
    end
  end
end
