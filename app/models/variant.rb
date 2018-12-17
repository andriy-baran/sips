class Variant < ApplicationRecord
  attribute :price, MoneyType.new
  attribute :weight, WeightType.new

  belongs_to :product
end
