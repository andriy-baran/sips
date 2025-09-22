class Manage::Products::CreateHandler < ApplicationHandler
  form  Manage::Products::ModelForm

  memoize def product
    Product.new
  end

  def add_to_stock!
    return if product.persisted?

    PointOfSale.find_each do |pos|
      PosProductStock.create!(pos_id: pos.id, product_id: product.id, on_hand: 0.0)
    end
  end

  def form_attributes
    { model: [:manage, product], id: helpers.dom_id(product) }
  end

  def create
    product.assign_attributes(params.product.to_h)
    ApplicationRecord.transaction do
      product.save!
      add_to_stock!
    rescue => e
      binding.pry
      errors.add(:base, :unprocessable_entity, message: e.message)
      raise ActiveRecord::Rollback
    end
  end
end
