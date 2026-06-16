class Course < ApplicationRecord
  belongs_to :category

  belongs_to :user

  has_many :registrations
  has_many :students, through: :registrations, source: :user
end
