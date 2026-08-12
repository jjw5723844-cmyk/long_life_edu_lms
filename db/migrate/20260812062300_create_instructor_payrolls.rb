class CreateInstructorPayrolls < ActiveRecord::Migration[8.1]
  def change
    create_table :instructor_payrolls do |t|
      t.references :instructor_profile, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :target_month
      t.integer :teaching_hours
      t.integer :calculated_amount
      t.integer :status

      t.timestamps
    end
  end
end
