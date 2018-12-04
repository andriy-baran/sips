class MoneyType < ActiveModel::Type::Value
  def cast(value)
    value.to_money
  end

  def serialize(value)
    value.format(symbol: value.currency.to_s)
  end
end

class Cashbox < ApplicationRecord
  attribute :price, MoneyType.new
end
