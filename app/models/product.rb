class Product < ApplicationRecord
  has_one :variant, dependent: :destroy
  has_many :stocks, -> { where(kind: 'checkout') }, class_name: 'Stock'
end
