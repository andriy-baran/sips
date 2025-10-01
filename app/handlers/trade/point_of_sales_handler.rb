class Trade::PointOfSalesHandler < ApplicationHandler
  url_params do
    integer :id, presence: true
  end

  finder :point_of_sale, -> { PointOfSale.find_by(id: url_params.id) }, validate_existence: true

  def products
    point_of_sale.products.joins(:product_stocks).includes(:variants).where('pos_product_stocks.on_hand > 0').distinct
  end
end
