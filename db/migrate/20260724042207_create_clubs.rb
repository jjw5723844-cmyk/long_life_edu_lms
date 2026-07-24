class CreateClubs < ActiveRecord::Migration[8.1]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :category
      t.text :description
      t.string :leader_name
      t.integer :max_members
      t.integer :current_members
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
