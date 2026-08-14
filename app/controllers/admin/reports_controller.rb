module Admin
  class Admin::ReportsController < ApplicationController
    # 관리자 접근 권한 검증
    before_action :require_admin

    # 행정 통계 대시보드 메인
    def index
      # Model을 통한 종합 KPI 수집
      @total_revenue = CourseRegistration.total_revenue
      @approved_count = CourseRegistration.approved_count
      @pending_count = CourseRegistration.pending_count
      @refunded_count = CourseRegistration.refunded_count
      @total_courses = Course.total_courses_count
    end

    # 수강신청 전체 데이터 CSV 다운로드
    def export_csv
      # Model의 CSV 생성 로직 호출 및 파일 응답 처리
      csv_data = CourseRegistration.to_csv
      filename = "롱라이프_평생학습관_수강신청_행정통계_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.csv"

      send_data csv_data, filename: filename, type: "text/csv; charset=utf-8; header=present", disposition: "attachment"
    end

    private

    # 관리자 권한 확인
    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "관리자 전용 기능입니다."
      end
    end
  end
end
