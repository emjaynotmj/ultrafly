class Booking < ActiveRecord::Base
  belongs_to :flight
  belongs_to :user
  has_many :passengers

  validates :booking_ref_code, presence: true
  validates :flight_id, presence: true
  validates :total_price, presence: true

  accepts_nested_attributes_for :passengers,
                                allow_destroy: true
end
