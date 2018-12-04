class CreateCashboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :cashboxes do |t|
      t.integer :pos_id
      t.integer :product_id
      t.string :price
      t.string :kind

      t.timestamps
    end
  end
end
