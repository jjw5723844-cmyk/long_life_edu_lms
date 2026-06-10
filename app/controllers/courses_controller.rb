class CoursesController < ApplicationController
  # 액션 실행전 @course 자동 조회
  before_action :set_course, only: %i[ show edit update destroy ]

  # 1. 개설된 모든 강좌들을 가져오는 액션
  def index
    @courses = Course.all
  end

  # 2. 특정 혹은 키워드별 강좌 하나를 가져오는 세부 액션
  # GET /courses/1 or /courses/1.json
  def show
    @course = Course.find(params[:id])
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

  # 강좌 삭제
  def destroy
    @course.destroy
    redirect_to course_path, notice: "강좌가 성공적으로 폐강(삭제)되었습니다."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params.expect(:id))
    end

    # 스트롱 파라미터를 통해 허용할 컬럼들을 DB 구조에 맞게 확인
    def course_params
      params.expect(course: [ :title, :description, :instructor_name, :max_students, :category_id ])
    end
end
