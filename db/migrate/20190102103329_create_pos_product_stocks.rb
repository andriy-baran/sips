class CreatePosProductStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :pos_product_stocks do |t|
      t.references :pos
      t.references :product, foreign_key: true
      t.float :on_hand, default: 0.0

      t.timestamps
    end
  end
end
