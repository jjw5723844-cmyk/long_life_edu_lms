class CreateClubActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :club_activities do |t|
      t.references :club, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :image_url
      t.date :activity_date

      t.timestamps
    end
  end
end
