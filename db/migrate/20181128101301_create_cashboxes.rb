class CreateCashboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :cashboxes do |t|
      t.references :pos, foreign_key: true
      t.references :product, foreign_key: true
      t.references :account, foreign_key: true
      t.string :price
      t.string :kind
      t.integer :quantity

      t.timestamps
    end
  end
end
