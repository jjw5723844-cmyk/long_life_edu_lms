class Course < ApplicationRecord
  belongs_to :category

  has_many :registrations
  has_many :users, through: :registrations
end
