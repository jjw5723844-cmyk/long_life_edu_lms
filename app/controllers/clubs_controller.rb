class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit, :update, :destroy, :join]

  def index
    @clubs = Club.all.order(created_at: :desc)
      # 카테고리 필터링 조건 추가
      if params[:category],present? && params[:category] ! = "전체"
        @clubs = @clubs.where(category: params[:category])
      end
      # 동아리명 및 동아리 설명 검색어 조건 추가
      if params[:query].present?
        @clubs = @clubs.where("name LIKE ? OR description LIKe ?", query_param, query_param)
      end
  end

  def show
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      redirect_to clubs_path, notice: "학습동아리가 성공적으로 개설 신청되었습니다."
    else
      render :new, status: :unpeocessable_entity
    end
  end

  def edit
  end

  def update
    if @club.update(club_params)
      redirect_to club_path(@club), notice: "동아리 정보가 수정되었습니다."
    else
      render :edit, status: :unpeocessable_entity
    end
  end

  def destroy
    @club.destroy
    redirect_to clubs_path, notice: "학습동아리가 삭제되었습니다."
  end

  def join
    # 동아리 가입 처리 로직(성공 안내 메시지)
    redirect_to club_path(@club), notice: "동아리 가입 신청이 완료되었습니다."
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:name, :category, :description, :leader_name, :max_members, :current_members, :status)
  end
end