class AddBookingIdToPassengersTable < ActiveRecord::Migration
  def change
    add_column :passengers, :booking_id, :integer
  end
end
