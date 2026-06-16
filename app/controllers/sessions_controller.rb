class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url, notice: "성공적으로 로그인 되었습니다."
    else
      redirect_to new_session_path, alert: "이메일 주소 또는 비밀번호가올바르지 않습니다."
    end
  end

  # 로그아웃 기능 추가
  def destroy
    terminate_session
    redirect_to root_path, notice: "안전하게 로그아웃 되었습니다.", status: :see_other
  end
end
