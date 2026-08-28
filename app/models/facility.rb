class Facility < ApplicationRecord
  has_many :facility_reservations, dependent: :destroy
end
