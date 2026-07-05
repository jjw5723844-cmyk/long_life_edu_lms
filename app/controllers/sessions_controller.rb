class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
  end

  def create
    # 폼 설계에 상관없이 이메일과 비밀번호를 안전하게 추출하도록 설정
    auth_params = params[:user] ? params.require(:user).permit(:email_address, :password) : params.permit(:email_address, :password)

    if user = User.authenticate_by(auth_params)
      start_new_session_for user

      # 로그인 후 각 사용자 권한에 따른 대시보드 이동 분기 구조 설정
      if user.admin?
        redirect_to after_authentication_url, notice: "성공적으로 로그인 되었습니다."
      elsif user.teacher?
        redirect_to new_session_path, notice: "성공적으로 로그인 되었습니다."
      else
        # 학습자용 계정은(dashboard_path)로 다이렉트 출력하도록 설정
        redirect_to dashboard_path, notice: "성공적으로 로그인 되었습니다."
      end
    else
      redirect_to new_session_path, alert: "이메일 주소 또는 비밀번호가 올바르지 않습니다."
    end
  end

  # 로그아웃 기능 추가
  def destroy
    terminate_session
    redirect_to root_path, notice: "안전하게 로그아웃 되었습니다.", status: :see_other
  end
end
