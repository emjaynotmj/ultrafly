class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :booking_ref_code
      t.integer :passengers
      t.integer :total_price
      t.integer :flight_id
      t.string :flight_code
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
