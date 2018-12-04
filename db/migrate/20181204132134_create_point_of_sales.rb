class CreatePointOfSales < ActiveRecord::Migration[5.2]
  def change
    create_table :point_of_sales do |t|
      t.references :place, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
