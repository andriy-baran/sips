class AddSomeFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string
    add_column :users, :phone, :string
    add_column :users, :rate_per_hour, :float
    add_column :users, :avatar, :string
  end
end
