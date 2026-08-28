class NoticesController < ApplicationController
  # 공지사항 목록(index)과 상세 내용(show)은 로그인 없이 누구나 조회 가능하도록 설정
  skip_before_action :require_authentication, only: [ :index, :show ], raise: false
  before_action :set_notice, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_admin!, only: [ :new, :create, :edit, :update, :destroy ]

  # 공지사항 목록 페이지
  def index
    # 중요 공지사항들 중 중요 공지가 먼저 나열되고, 그 다음부터는 최신순으로 정렬하여 데이터를 가져와 페이지에 나타나도록 한다.
    @notices = Notice.order(is_pinned: :desc, created_at: :desc)
  end

  # 공지사항 상세 페이지
  def show
    # params[:id]를 통해 전달받은 공지사항 ID를 기반으로 해당 공지사항 데이터를 가져와 뷰로 전달한다.
    @notice = Notice.find(params[:id])

    # 공지사항 상세 페이지가 조회될 때마다 조회수(view_count)를 1 증가시킨다.
    @notice.increment!(:view_count)
  end

  # 공지사항 작성 페이지
  def new
    @notice = Notice.new
  end

  # 공지사항 DB 저장 처리
  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      redirect_to notice_path(@notice), notice: "공지사항이 성공적으로 등록되었습니다."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 공지사항 수정 페이지
  def edit
  end

  # 공지사항 수정 처리
  def update
    if @notice.update(notice_params)
      redirect_to notice_path(@notice), notice: "공지사항이 성공적으로 수정되었습니다."
    end
  end

  def destroy
    @notice.destroy
    redirect_to notices_path, notice: "공지사항이 성공적으로 삭제되었습니다."
  end

  private

  def set_notice
    @notice = Notice.find(params[:id])
  end

  # 공지사항 파라미터 허용 설정
  def notice_params
    params.require(:notice).permit(:title, :content, :is_pinned)
  end

  # 관리자 권한 접근 제한
  def ensure_admin!
    unless respond_to?(:current_user) && current_user&.admin?
      redirect_to notices_path, alert: "관리자 권한이 필요합니다."
    end
  end
end
