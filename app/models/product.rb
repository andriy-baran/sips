class Product < ApplicationRecord
  has_one :variant, dependent: :destroy
  belongs_to :stock
end
