class Product < ApplicationRecord
  has_one :variant, dependent: :destroy
end
