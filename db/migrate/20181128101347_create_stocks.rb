class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :pos
      t.references :product, foreign_key: true
      t.references :account, foreign_key: true
      t.string :weight
      t.string :kind
      t.integer :quantity

      t.timestamps
    end
  end
end
