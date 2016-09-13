class Flight < ActiveRecord::Base

  has_many :bookings
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :arrival_airport, class_name: 'Airport'

  accepts_nested_attributes_for :bookings

  def self.search(departs, arrives, date, passengers)
    sql_query = "departure_date >= ? and available_seats > ?"
    flights = where(sql_query, date, passengers)
    flights.uniq(&:date).select { |flight| flight.departure_airport_id == departs && flight.arrival_airport_id == arrives }
  end
end
