class AddColumnToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :arrival_date, :datetime
  end
end
