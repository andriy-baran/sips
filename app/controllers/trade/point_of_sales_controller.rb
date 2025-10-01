class Trade::PointOfSalesController < ApplicationController
  before_action :authenticate_account!

  action :index, handler: nil do |handler|
    @point_of_sales = handler.point_of_sales
  end

  # GET /trade/point_of_sales/1
  action :show, handler: nil do |handler|
    @point_of_sale = handler.point_of_sale
    @products = handler.products
  end
end
