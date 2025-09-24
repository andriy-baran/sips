class WeightType < ActiveModel::Type::Value
  def cast(value)
    return value if value.is_a? Unitwise::Measurement

    Unitwise(*value.split(' ')) unless value.nil?
  rescue StandardError
    nil
  end

  def serialize(value)
    value.to_s
  end
end
