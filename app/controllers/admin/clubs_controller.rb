module Admin
  class ClubsController < ApplicationController
    # 접근 권한 검증
    before_action :require_authentication
    before_action :ensure_admin!
    # 대상 동아리 조회
    before_action :set_club, only: [:approve, :reject]

    # 승인 대기 및 활동 보고서 데이터 바인딩
    def index
      @pending_clubs = Club.waiting_approval.includes(:user)
      @approved_clubs = Club.approved_clubs.includes(:user)
      @pending_reports = ClubActivityReport.pending_reviews.includes(club: :user)
    end

    # 동아리 승인
    def approve
      @club.approve!
      redirect_to admin_clubs_path, notice: "학습동아리 등록이 승인되었습니다."
    end

    # 동아리 반려
    def reject
      @club.reject!
      redirect_to admin_clubs_path, notice: "학습동아리 등록이 반려되었습니다."
    end

    # 활동 보고서 검토 완료
    def review_report
      report = ClubActivityReport.find(params[:report_id])
      report.review!
      redirect_to admin_clubs_path, notice: "동아리 활동 보고서 검토가 완료되었습니다."
    end

    private

    # ID 기반 Club 데이터 조회
    def set_club
      @club = Club.find(params[:id])
    end
  end
end