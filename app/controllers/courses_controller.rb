class CoursesController < ApplicationController
  # 액션 실행 전 @course 자동 조회
  before_action :set_course, only: %i[ show edit update destroy ]

  # 1차 보안 차단: 비로그인 및 학생 유저가 강좌를 '조작'하는 것을 전면 차단
  before_action :require_teacher_or_admin, only: [ :new, :create, :edit, :update, :destroy ]

  # 2차 보안 차단: 강사 권한이 있더라도 '자신이 개설한 강좌'가 아니면 수정/삭제를 불허
  before_action :ensure_course_owner_or_admin, only: [ :edit, :update, :destroy ]

  # 목록과 상세 페이지는 누구나 볼 수 있게 허용
  allow_unauthenticated_access only: %i[ index show ]

  # 비로그인 허용 페이지라 하더라도, 로그인한 계정이라면 쿠키를 읽어 세션을 복구
  before_action :resume_session, only: %i[ index show ]

  # 1. 개설된 모든 강좌들을 가져오는 액션
  def index
    @courses = Course.includes(:category, :registrations).all.order(created_at: :desc)
  end

  # 2. 특정 강좌 하나를 가져오는 세부 액션
  def show
    # @set_course에서 필터링을 통한 예외 처리를 하기에 안전하게 조회
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # 수정 폼 화면을 보여주는 액션
  def edit
    # ensure_course_owner_or_admin을 통과했으므로 안전하게 화면 진입
  end

  # 강좌 생성 액션
  def create
    # 현재 로그인한 강사(current_user)의 데이터와 연동하여 강좌를 생성
    @course = current_user.courses.build(course_params)

    # 편의 기능: 입력 폼에서 강사 이름을 누락하더라도, 현재 로그인한 유저의 이름을 기본값으로 설정
    @course.instructor_name ||= current_user.name

    if @course.save
      redirect_to @course, notice: "🎉 강좌가 성공적으로 개설되었습니다."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 강의 데이터 수정(DB 연동)
  def update
    if @course.update(course_params)
      redirect_to @course, notice: "강좌 정보가 성공적으로 수정되었습니다."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 강좌 삭제 액션
  def destroy
    @course.destroy
      redirect_to courses_url, notice: "강좌가 성공적으로 폐강(삭제)되었습니다.", status: :see_other
  end

  private
    # 파라미터 매칭 규격
    def set_course
      @course = Course.find_by(id: params.expect(:id)) # 존재하지 않는 강좌에 접근 시 다른 보안 필터로 가기 전에 여기서 즉시 차단(강력한 보안성 보장)

      if @course.nil?
        redirect_to courses_url, alert: "존재하지 않거나 이미 폐강된 강좌입니다.", status: :see_other
      end
    end

    # 최고 관리자(admin)이거나, 강좌의 user_id가 현재 로그인한 유저와 일치해야 함
    def ensure_course_owner_or_admin
      unless current_user.admin? || @course.user_id == current_user.id
        redirect_to courses_url, alert: "본인이 개설한 강좌만 수정하거나 폐강할 수 있습니다."
      end
    end

    # 스트롱 파라미터를 통해 허용할 컬럼들을 DB 구조에 맞게 확인 (params.expect 사양)
    def course_params
      params.expect(course: [ :title, :description, :instructor_name, :max_students, :category_id, :thumbnail ])
    end
end
