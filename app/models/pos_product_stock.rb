class PosProductStock < ApplicationRecord
  belongs_to :pos, class_name: 'PointOfSale'
  belongs_to :product

  scope :by_product_id, ->(product_id) { where(product_id: product_id) }
  scope :by_pos_id, ->(pos_id) { where(pos_id: pos_id) }
end
