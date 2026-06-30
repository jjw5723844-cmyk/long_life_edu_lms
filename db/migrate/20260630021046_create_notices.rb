class CreateNotices < ActiveRecord::Migration[8.1]
  def change
    create_table :notices do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :view_count, default: 0, null: false # 조회수 기본값은 0으로 설정
      t.boolean :is_pinned, default: false, null: false # 중요 공지사항 고정값 설정

      t.timestamps
    end
  end
end
