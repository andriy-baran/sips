class Manage::Products::CreateHandler < ApplicationHandler
  form  Manage::Products::UpdateHandler.form_definition

  memoize def product
    Product.new
  end

  def add_to_stock!
    PointOfSale.find_each do |pos|
      PosProductStock.create!(pos_id: pos.id, product_id: product.id, on_hand: 0.0)
    end
  end

  def form_attributes
    { model: [:manage, product], id: helpers.dom_id(product) }
  end

  def call
    product.assign_attributes(form_params.to_h)
    ApplicationRecord.transaction do
      product.save!
      add_to_stock!
    rescue => e
      errors.add(:base, :unprocessable_entity, message: e.message)
      raise ActiveRecord::Rollback
    end
  end
end
