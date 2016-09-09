class RemovePassengersFieldFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :passengers
  end
end
