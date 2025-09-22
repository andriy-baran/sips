class Manage::PointOfSales::CreateHandler < ApplicationHandler
  form Manage::PointOfSales::UpdateHandler.form_definition

  verify memoize def point_of_sale
    ::PointOfSale.new(form_params.to_h)
  end

  def call
    point_of_sale.save
    Product.all.each do |product|
      PosProductStock.create(pos_id: point_of_sale.id, product_id: product.id, on_hand: 0.0)
    end
  end
end
