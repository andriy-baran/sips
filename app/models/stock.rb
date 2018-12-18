class Stock < ApplicationRecord
  attribute :weight, WeightType.new
end
