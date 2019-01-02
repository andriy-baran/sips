class PointOfSale < ApplicationRecord
  belongs_to :place
  has_many :accounts
  has_many :product_stocks, class_name: 'PosProductStock', foreign_key: :pos_id
end
