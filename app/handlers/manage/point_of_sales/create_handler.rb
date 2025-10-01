class Manage::PointOfSales::CreateHandler < ApplicationHandler
  form Manage::PointOfSales::ModelForm

  def form_attributes
    { model: [:manage, point_of_sale] }
  end

  verify memoize def point_of_sale
    PointOfSale.new(form_params.to_h)
  end

  def on_validation_success
    call if action.create?
  end

  def call
    PointOfSale.transaction do
      point_of_sale.save!
      Product.all.each do |product|
        PosProductStock.create(pos_id: point_of_sale.id, product_id: product.id, on_hand: 0.0)
      end
    end
  end
end
