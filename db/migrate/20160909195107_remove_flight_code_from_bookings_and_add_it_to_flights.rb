class RemoveFlightCodeFromBookingsAndAddItToFlights < ActiveRecord::Migration
  def change
    remove_column :bookings, :flight_code
    add_column :flights, :flight_code, :string
  end
end
