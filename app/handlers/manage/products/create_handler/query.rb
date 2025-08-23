class Manage::Products::CreateHandler
  class Query < ::SteelWheel::Query
    verify memoize def product
      Product.new(title: title)
    end

    verify memoize def variant
      product.build_variant(weight: weight, price: price)
    end
  end
end
