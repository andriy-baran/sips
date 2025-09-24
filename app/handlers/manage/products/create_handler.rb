class Manage::Products::CreateHandler < ApplicationHandler
  form  Manage::Products::ModelForm

  verify memoize def product
    Product.new(form_params.to_h)
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

  def call
    ApplicationRecord.transaction do
      product.save!
      add_to_stock!
    rescue => e
      errors.add(:base, :unprocessable_entity, message: e.message)
      raise ActiveRecord::Rollback
    end
  end
end
