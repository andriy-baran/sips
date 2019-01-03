class PointOfSale < ApplicationRecord
  belongs_to :place
  has_many :accounts
  has_many :product_stocks, class_name: 'PosProductStock', foreign_key: :pos_id

  def product_stock(product)
    product_stocks.by_product_id(product.id).first_or_create
  end
end
