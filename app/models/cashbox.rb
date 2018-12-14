class Cashbox < ApplicationRecord
  attribute :price, MoneyType.new
end
