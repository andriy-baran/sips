class Variant < ApplicationRecord
  attribute :price, MoneyType.new
  attribute :weight, WeightType.new

  belongs_to :product

  validates :weight, :price, presence: true
  validates :weight, format: { with: /\A[0-9]+\s[g|kg]\z/ }

  def weight_value
    weight.to_s.split(' ').first
  end

  def weight_unit
    weight.to_s.split(' ').last
  end

  def price_value
    price.to_f
  end

  def price_currency
    price.currency.to_s
  end
end
