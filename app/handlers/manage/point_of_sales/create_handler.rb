class Manage::PointOfSales::CreateHandler < ApplicationHandler
  params Manage::PointOfSales::UpdateHandler.params_definition

  verify memoize def point_of_sale
    ::PointOfSale.new(params.point_of_sale.to_h)
  end

  def call
    pos.save
    ::Product.all.each do |product|
      ::PosProductStock.create(pos_id: pos.id, product_id: product.id, on_hand: 0.0)
    end
  end
end
