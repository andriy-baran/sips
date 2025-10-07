class Manage::CheckinsController < ApplicationController
  before_action :authenticate_account!

  def index
    @point_of_sale = PointOfSale.find(params[:point_of_sale_id])
    reports = Stock.includes(:product)
      .on_day
      .by_pos_id(@point_of_sale.id)
      .where('stocks.kind = ?', 'checkin')
      .where('stocks.quantity = 1')
      .group('stocks.product_id, stocks.id')
    @reports = reports.reject do |report|
      Stock.checkouted.on_day.by_product_id(report.product).where('stocks.created_at > ?', report.created_at).first
    end
    if @reports.any?
      @products = Product.where('id NOT IN (?)', @reports.map(&:product_id))
    else
      @products = Product.all
    end
  end

  action :create, handler: 'trade/checkouts/create' do |handler|
    handler.success do
      render partial: 'checkin',
             locals: { stock: handler.stock, point_of_sale: handler.point_of_sale, product_stock: handler.product_stock}
    end
  end

  action :edit do |handler|
    render partial: 'report_form', locals: { product: handler.stock.product, point_of_sale: handler.point_of_sale, stock: handler.stock, product_stock: handler.product_stock }
  end

  action :update do |handler|
    render partial: 'checkin', locals: { stock: handler.stock, point_of_sale: handler.point_of_sale, product_stock: handler.product_stock }
  end
end
