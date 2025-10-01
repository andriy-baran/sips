class Trade::Checkouts::CreateHandler < ApplicationHandler
  url_params do
    integer :product_id
    integer :point_of_sale_id
    float :weight_kilogram, normalize: ->(v) { v.sub(',', '.') }
  end

  finder :product, -> { Product.find_by(id: url_params.product_id) }, validate_existence: true
  finder :point_of_sale, -> { PointOfSale.find_by(id: url_params.point_of_sale_id) }, validate_existence: true
  finder :product_stock, -> { PosProductStock.find_by(pos_id: url_params.point_of_sale_id, product_id: url_params.product_id) }, validate_existence: true

  def new_stock_attrs
    {
      product_id: url_params.product_id,
      pos_id: url_params.point_of_sale_id,
      account_id: helpers.current_account.id,
      quantity: 1,
      weight_kilogram: url_params.weight_kilogram,
      kind: 'checkout'
    }
  end

  verify memoize def stock
    Stock.create(new_stock_attrs)
  end

  def call
    total = product_stock.on_hand + url_params.weight_kilogram
    product_stock.update_column(:on_hand, total)
  end

  def on_validation_success
    call
  end
end
