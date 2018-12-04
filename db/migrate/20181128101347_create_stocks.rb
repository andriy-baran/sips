class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :pos_id
      t.integer :product_id
      t.string :weight
      t.string :kind

      t.timestamps
    end
  end
end
