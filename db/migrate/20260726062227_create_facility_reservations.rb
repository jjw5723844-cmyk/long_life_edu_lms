class CreateFacilityReservations < ActiveRecord::Migration[8.1]
  def change
    create_table :facility_reservations do |t|
      t.references :facility, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :reservation_date
      t.string :start_time
      t.string :end_time
      t.string :purpose
      t.integer :headcount
      t.string :status

      t.timestamps
    end
  end
end
