class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :departure_airport
      t.string :arrival_airport
      t.integer :available_seats
      t.datetime :departure_date
      t.decimal :price
      t.string :airline_name

      t.timestamps null: false
    end
  end
end
