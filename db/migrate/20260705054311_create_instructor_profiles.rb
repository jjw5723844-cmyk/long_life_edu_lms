class CreateInstructorProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :instructor_profiles do |t|
      t.references :user, null: false, foreign_key: true # 강사 유저 계정 연동
      t.string :specialty # 강의를 맡는 강사의 전문 분야
      t.text :bio # 강사의 약력 및 소개 본문

      t.timestamps
    end
  end
end
