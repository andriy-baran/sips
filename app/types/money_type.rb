class MoneyType < ActiveModel::Type::Value
  def cast(value)
    value.to_money
  end

  def serialize(value)
    value.format(symbol: value.currency.to_s)
  end
end
