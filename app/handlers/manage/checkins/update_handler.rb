class Manage::Checkins::UpdateHandler < ApplicationHandler
  url_params do
    integer :id, presence: true
    integer :point_of_sale_id, presence: true
    integer :pos_product_stock_id
    integer :product_id, presence: true
    float :weight_kilogram, normalize: ->(v) { v.sub(',', '.') }, presence: true
  end

  finder :stock, -> { Stock.find_by(id: url_params.id) }, validate_existence: true
  finder :point_of_sale, -> { PointOfSale.find_by(id: url_params.point_of_sale_id) }, validate_existence: true

  memoize def product_stock
    if url_params.pos_product_stock_id.present?
      PosProductStock.find(url_params.pos_product_stock_id)
    else
      PosProductStock.where(pos_id: url_params.point_of_sale_id, product_id: url_params.product_id).first_or_create
    end
  end

  def update
    weight_kilogram = url_params.weight_kilogram
    total = product_stock.on_hand - stock.weight_kilogram + weight_kilogram
    stock.update_column(:weight_kilogram, weight_kilogram)
    product_stock.update_column(:on_hand, total)
  end

  def on_validation_success
    update if current_action.update?
  end
end
