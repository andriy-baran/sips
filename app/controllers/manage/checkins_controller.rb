class Manage::CheckinsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_point_of_sale
  before_action :set_pos_product_stock, on: [:create, :edit, :update]
  before_action :set_stock, only: [:edit, :update]

  def index
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

  def create
    result = Trade::Checkouts::CreateHandler.handle(input: params.to_unsafe_h) do |i|
      i.query.current_account = current_account
      i.query.product_stock = @product_stock
    end
    if result.success?
      render partial: 'checkin',
             locals: {
               stock: result.stock,
               point_of_sale: result.point_of_sale,
               product_stock: @product_stock
             }
    end
  end

  def edit
    render partial: 'report_form', locals: { product: @stock.product, point_of_sale: @point_of_sale, stock: @stock, product_stock: @product_stock }
  end

  def update
    weight_kilogram = params[:weight_kilogram].sub(',', '.').to_f
    total = (@product_stock.on_hand - @stock.weight_kilogram) + weight_kilogram
    @stock.update_column(:weight_kilogram, weight_kilogram)
    @product_stock.update_column(:on_hand, total)
    render partial: 'checkin', locals: { stock: @stock, point_of_sale: @point_of_sale, product_stock: @product_stock }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pos_product_stock
      if params[:pos_product_stock_id].present?
        @product_stock = PosProductStock.find(params[:pos_product_stock_id])
      else
        @product_stock = PosProductStock.where(pos_id: params[:point_of_sale_id], product_id: params[:product_id]).first_or_create
      end
    end

    def set_point_of_sale
      @point_of_sale = PointOfSale.find(params[:point_of_sale_id])
    end

    def set_stock
      @stock = Stock.find(params[:id])
    end
end
