class AddColumnToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :state, :string
  end
end
