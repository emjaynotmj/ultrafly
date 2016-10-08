class RemoveColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :firstname, :string
    remove_column :users, :lastname, :string
    remove_column :users, :gender, :string
    remove_column :users, :mobile_number, :string
  end
end
