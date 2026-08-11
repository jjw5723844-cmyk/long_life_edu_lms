class AddAdministrativeFieldsToCourseRegistrations < ActiveRecord::Migration[8.1]
  def change
    add_column :course_registrations, :discount_proof, :string
    add_column :course_registrations, :waitlist_position, :integer
    add_column :course_registrations, :cancelled_at, :datetime
    add_column :course_registrations, :paid_amount, :integer
    add_column :course_registrations, :refund_amount, :integer
  end
end
