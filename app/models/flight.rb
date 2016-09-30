class Flight < ActiveRecord::Base
  belongs_to :arrival_airport, class_name: "Airport"
  belongs_to :departure_airport, class_name: "Airport"
  has_many :bookings

  validates :airline_name, presence: true
  validates :arrival_airport_id, presence: true
  validates :arrival_date, presence: true
  validates :available_seats, presence: true
  validates :departure_airport_id, presence: true
  validates :departure_date, presence: true
  validates :flight_code, presence: true
  validates :price, presence: true

  def self.available_flights
    current_time = DateTime.tomorrow
    where("departure_date >= ?", current_time).sort_by_departure_date
  end

  def self.search(search_params)
    sql_query = "departure_date >= ? and available_seats > ?"
    flights = where(
      sql_query,
      search_params[:departure_date],
      search_params[:number_of_passengers].to_i
    )
    flights.sort_by_departure_date.select do |flight|
      flight.departure_airport_id == search_params[:from].to_i &&
        flight.arrival_airport_id == search_params[:to].to_i
    end
  end

  def self.sort_by_departure_date
    order("departure_date")
  end
end
