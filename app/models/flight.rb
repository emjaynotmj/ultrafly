class Flight < ActiveRecord::Base
  belongs_to :arrival_airport, class_name: 'Airport'
  belongs_to :departure_airport, class_name: 'Airport'
  has_many :bookings

  validates :airline_name, presence: true
  validates :arrival_airport_id, presence: true
  validates :arrival_date, presence: true
  validates :available_seats, presence: true
  validates :departure_airport_id, presence: true
  validates :departure_date, presence: true
  validates :flight_code, presence: true
  validates :price, presence: true

  accepts_nested_attributes_for :bookings

  def self.search(
    departure_airport,
    arrival_airport,
    departure_date,
    number_of_passengers
  )
    sql_query = 'departure_date >= ? and available_seats > ?'
    flights = where(sql_query, departure_date, number_of_passengers)
    flights.order!('departure_date')
    flights.select do |flight|
      flight.departure_airport_id == departure_airport &&
        flight.arrival_airport_id == arrival_airport
    end
  end
end