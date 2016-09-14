class Flight < ActiveRecord::Base

  has_many :bookings
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :arrival_airport, class_name: 'Airport'

  accepts_nested_attributes_for :bookings

  def self.search(departure_airport, arrival_airport, date, passengers)
    sql_query = "departure_date >= ? and available_seats > ?"
    flights = where(sql_query, date, passengers)
    flights.uniq(&:date).select do |flight|
      flight.departure_airport_id == departure_airport && flight.arrival_airport_id == arrival_airport
    end
  end
end
