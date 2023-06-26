class Variant < ApplicationRecord
  attribute :price, MoneyType.new
  attribute :weight, WeightType.new

  belongs_to :product

  validates :weight, :price, presence: true
  validates :weight, allow_blank: true, format: { with: /\A[0-9]+\s[g|kg]\z/ }
end
