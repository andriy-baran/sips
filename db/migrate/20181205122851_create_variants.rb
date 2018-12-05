class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.references :product, foreign_key: true
      t.string :weight
      t.string :price

      t.timestamps
    end
  end
end
