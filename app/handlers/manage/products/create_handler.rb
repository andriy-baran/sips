class Manage::Products::CreateHandler < ApplicationHandler
  params do
    has :product, presence: true do
      string :title, presence: true
      string :weight, presence: true, format: { with: /\A[0-9]+\s[g|kg]\z/ }, normalize: ->(v) { v.sub('gram', 'g') }
      string :price, presence: true
    end
  end

  verify memoize def product
    Product.new(title: params.product.title)
  end

  verify memoize def variant
    product.build_variant(weight: params.product.weight, price: params.product.price)
  end

  def add_to_stock!
    ::PointOfSale.find_each do |pos|
      ::PosProductStock.create!(pos_id: pos.id, product_id: product.id, on_hand: 0.0)
    end
  end

  def call(flow)
    ::ApplicationRecord.transaction do
      product.save!
      variant.save!
      add_to_stock!
    rescue => e
      flow.errors.add(:base, :unprocessable_entity, e.message)
      raise ActiveRecord::Rollback
    end
  end
end
