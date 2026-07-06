class CourseReviewsController < ApplicationController
  # 후기 작성 및 삭제는 로그인 시 해당 회원만 세션에 요청할 수 있도록 처리
  before_action :require_authentication

  # 강좌별 독립된 후기 인덱스 뷰에 데이터를 공급하기 위해 index 액션을 구현하고, 의존 데이터를 바인딩
  def index
    @course = Course.find(params[:course_id])
    @course_reviews = @course.course_reviews.includes(:user).order(created_at: :desc)
  end

  def create
    @course = Course.find(params[:course_id])
    # 현재 로그인한 사용자의 계정과 연동된 학습 후기 객체를 생성
    @course_review = @course.course_reviews.build(course_review_params)
    @course_review.user = current_user

    if @course_review.save
      # 학습 후기 성공 시 알림 메시지와 함께 해당 강좌의 상세 화면으로 이동
      redirect_to @course, notice: "성공적으로 등록되었습니다. 소중한 의견 감사드립니다!"
    else
      # 후기 작성의 최소 조건(10자 이상, 학습만족도 1점~5점 별표) 미충족시 에러 안내와 함께 강좌 상세 화면으로 이동
      redirect_to @course, alert: "등록에 실패했습니다. 본문은 최소 10자 이상, 별점은 1~5점 사이여야 합니다."
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    # 타인의 후기를 임의로 삭제할 수 없도록 오직 로그인된 유저가 작성한 후기 범위 내에서만 탐색하도록 설정(보안 강화)
    @course_review = current_user.course_reviews.find(params[:id])
    @course_review.destroy
    redirect_to @course, notice: "해당 학습 후기가 정상적으로 삭제되었습니다."
  end

  private

  def course_review_params
    # 대규모 할당 보안 취약점 방지를 위한 학습 후기의 평점과 내용만 명확히 필터링 하도록 설정
    params.require(:course_review).permit(:rating, :content)
  end
end
