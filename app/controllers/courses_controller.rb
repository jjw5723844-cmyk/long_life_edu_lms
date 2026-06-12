class CoursesController < ApplicationController
  # 액션 실행전 @course 자동 조회
  before_action :set_course, only: %i[ show edit update destroy ]
  allow_unauthenticated_access only: %i[ index show ]

  # 1. 개설된 모든 강좌들을 가져오는 액션
  def index
    @courses = Course.all
  end

  # 2. 특정 혹은 키워드별 강좌 하나를 가져오는 세부 액션
  # GET /courses/1 or /courses/1.json
  def show
    @course = Course.find_by(params[:id])

    if @course.nil?
      redirect_to courses_url, alert: "존재하지 않거나 이미 폐강된 강좌입니다.", status: :see_other
      nil
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # 수정 폼 화면을 보여주는 액션
  def edit
  end

  # 강좌 생성 액션
  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: "강좌가 성공적으로 개설되었습니다."
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
    @course = Course.find(params[:id])
    if @course.present? # 강좌가 존재할 경우에만 삭제를 진행하도록 서버 안정성을 강화시킨다.
      @course.destroy # set_course 액션으로 찾아낸 강좌 삭제
      flash[:notice] = "강좌가 성공적으로 폐강되었습니다."
    else
      flash[:notice] = "이미 폐강 처리된 강좌입니다."
    end

    redirect_to courses_url, notice: "강좌가 성공적으로 폐강(삭제)되었습니다.", status: :see_other
  end

  private
    def set_course
      @course = Course.find_by(id: params.expect(:id)) # 코드 삭제시 서버 안정성 강화
    end

    # 스트롱 파라미터를 통해 허용할 컬럼들을 DB 구조에 맞게 확인
    def course_params
      params.expect(course: [ :title, :description, :instructor_name, :max_students, :category_id ])
    end
end
