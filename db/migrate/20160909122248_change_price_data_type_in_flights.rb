class ChangePriceDataTypeInFlights < ActiveRecord::Migration
  def change
    change_column :flights, :price, :float
  end
end
