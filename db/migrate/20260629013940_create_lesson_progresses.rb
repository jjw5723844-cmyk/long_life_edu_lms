class CreateLessonProgresses < ActiveRecord::Migration[8.1]
  def change
    create_table :lesson_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      # nil 값 방지 => 기본 수강 상태를 미완료(false)로 강제
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
    # 동일 유저가 한 강의에 대해 중복 레코드를 쌓지 못하도록 유니크 제약 인덱스 추가.
    add_index :lesson_progresses, [ :user_id, :lesson_id ], unique: true
  end
end
