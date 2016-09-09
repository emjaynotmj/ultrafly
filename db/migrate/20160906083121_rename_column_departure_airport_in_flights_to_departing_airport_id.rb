class RenameColumnDepartureAirportInFlightsToDepartingAirportId < ActiveRecord::Migration
  def change
    rename_column :flights, :departure_airport, :departing_airport_id
    rename_column :flights, :arrival_airport, :arriving_airport_id
  end
end
