class Airport < ActiveRecord::Base
  has_many :arriving_flights,
           foreign_key: :arrival_airport_id,
           class_name: "Flight"
  has_many :departing_flights,
           foreign_key: :departure_airport_id,
           class_name: "Flight"

  validates :name, presence: true
  validates :state, presence: true
end
