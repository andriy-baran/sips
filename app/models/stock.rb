class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :pos, class_name: 'PointOfSale'

  scope :on_day, ->(time = Time.zone.now) {where('stocks.created_at > ? and stocks.created_at < ?', time.beginning_of_day, time.end_of_day) }
  scope :sold, -> { where(kind: 'sell') }
  scope :checkouted, -> { where(kind: 'checkout') }
  scope :by_product_id, ->(product_id) { where(product_id: product_id) }
  scope :by_pos_id, ->(pos_id) { where(pos_id: pos_id) }
end
