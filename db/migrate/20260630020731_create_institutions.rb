class CreateInstitutions < ActiveRecord::Migration[8.1]
  def change
    create_table :institutions do |t|
      t.string :name, null: false # 기관명
      t.string :greeting_title, null: false # 인사말 제목
      t.text :greeting_content, null: false # 인사말 본문
      t.text :mission, null: false # 기관의 미션
      t.text :core_values, null: false # 기관의 핵심 가치 리스트

      t.timestamps
    end
  end
end
