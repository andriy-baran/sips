class AddSomeFieldsToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :full_name, :string
    add_column :accounts, :phone, :string
    add_column :accounts, :rate_per_hour, :float
    add_column :accounts, :avatar, :string
  end
end
