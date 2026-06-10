class Course < ApplicationRecord
  belongs_to :category, optional: true

  has_many :registrations
  has_many :users, through: :registrations
end
