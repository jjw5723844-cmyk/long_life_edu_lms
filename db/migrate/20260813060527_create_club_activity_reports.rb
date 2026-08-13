class CreateClubActivityReports < ActiveRecord::Migration[8.1]
  def change
    create_table :club_activity_reports do |t|
      t.references :learning_club, null: false, foreign_key: true
      t.string :title
      t.date :activity_date
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
