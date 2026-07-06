class CreateCourseReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :course_reviews do |t|
      t.references :user, null: false, foreign_key: true # 후기를 작성한 학습자 회원 데이터 테이블과 연동
      t.references :course, null: false, foreign_key: true # 후기의 대상이 되는 개설된 강좌의 데이터 테이블과 연동
      t.integer :rating, null: false # 강의 만족도 평가를 위한 1~5 점 척도의 정수형 별점 데이터를 필수값으로 저장
      t.text :contnt, null: false # 학습자의 수강 후기 텍스트 본문을 필수값으로 저장

      t.timestamps
    end
  end
end
