class ChangeDataTypeInFlights < ActiveRecord::Migration
  def change
    change_column :flights, :departing_airport_id, :integer
    change_column :flights, :arriving_airport_id, :integer
  end
end
