class CreateCashboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :cashboxes do |t|
      t.references :pos
      t.references :product, foreign_key: true
      t.integer :account_id
      t.string :price
      t.string :kind
      t.integer :quantity

      t.timestamps
    end
  end
end
