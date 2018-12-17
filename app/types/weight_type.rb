class WeightType < ActiveModel::Type::Value
  def cast(value)
    Unitwise(*value.split(' ')) unless value.nil?
  end

  def serialize(value)
    value.to_s
  end
end
