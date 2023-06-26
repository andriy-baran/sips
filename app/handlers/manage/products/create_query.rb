class Manage::Products::CreateQuery < SteelWheel::Query
  validate :product, :variant

  memoize def new_product
    Product.new(title: title)
  end

  memoize def new_variant
    new_product.build_variant(weight: weight, price: price)
  end

  private

  def product
    errors.add(:unprocessable_entity, new_product.errors.full_messages.join("\n")) if new_product.invalid?
  end

  def variant
    errors.add(:unprocessable_entity, new_variant.errors.full_messages.join("\n")) if new_variant.invalid?
  end
end
