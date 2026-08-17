module Admin
  class ReportsController < ApplicationController
    # 접근 권한 검증
    before_action :require_authentication
    before_action :ensure_admin!

    # 행정 통계 대시보드 메인
    def index
      # Model을 통한 종합 KPI 수집
      @total_revenue = CourseRegistration.total_revenue
      @approved_count = CourseRegistration.approved_count
      @pending_count = CourseRegistration.pending_count
      @refunded_count = CourseRegistration.refunded_count
      @total_courses = Course.total_courses_count

      # 뷰에서 참조하는 @course_stats 데이터 수집 로직
      @course_stats = Course.includes(:user, :course_registrations).map do |course|
        approved = course.course_registrations.select(&:confirmed?).size
        # course_capacity 변수에 수강 정원 저장
        course_capacity = course.capacity
        fill_rate = course_capacity.positive? ? ((approved.to_f / course_capacity) * 100).round(1) : 0.0
        {
          id: course.id,
          title: course.title,
          instructor_name: course.user&.name || "미지정",
          approved_count: approved,
          capacity: course_capacity,
          fill_rate: fill_rate,
          total_revenue: course.course_registrations.select(&:confirmed?).sum { |r| r.paid_amount.to_i }
        }
      end
    end

    # 수강신청 전체 데이터 CSV 다운로드
    def export_csv
      # Model의 CSV 생성 로직 호출 및 파일 응답 처리
      csv_data = CourseRegistration.to_csv
      filename = "롱라이프_평생학습관_수강신청_행정통계_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.csv"

      send_data csv_data, filename: filename, type: "text/csv; charset=utf-8; header=present", disposition: "attachment"
    end
  end
end
