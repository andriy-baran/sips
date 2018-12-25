class Trade::CheckoutsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_point_of_sale
  before_action :set_stock, only: [:edit, :update]

  def index
    @reports = Stock.includes(:product)
      .where('stocks.pos_id = ?', params[:point_of_sale_id])
      .where('stocks.account_id = ?', current_account.id)
      .where('stocks.kind = ?', 'checkout')
      .where('stocks.created_at > ?', Time.zone.now.beginning_of_day)
      .where('stocks.created_at < ?', Time.zone.now.end_of_day)
      .where('stocks.quantity = 1')
      .group('stocks.product_id')
    if @reports.any?
      @products = Product.where('id NOT IN (?)', @reports.map(&:product_id))
    else
      @products = Product.all
    end
  end

  def create
    @product = Product.find_by(id: params[:product_id])
    if @product
      attrs = {
          product_id: params[:product_id],
          pos_id: params[:point_of_sale_id],
          account_id: current_account.id,
          quantity: 1,
          weight_kilogram: params[:weight_kilogram].sub(',', '.').to_f,
          kind: 'checkout'
      }
      @stock = Stock.create(attrs)
      render partial: 'checkout', locals: { stock: @stock, point_of_sale: @point_of_sale }
    end
  end

  def edit
    render partial: 'report_form', locals: { product: @stock.product, point_of_sale: @point_of_sale, stock: @stock }
  end

  def update
    @stock.update_column(:weight_kilogram, params[:weight_kilogram])
    render partial: 'checkout', locals: { stock: @stock, point_of_sale: @point_of_sale }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point_of_sale
      @point_of_sale = PointOfSale.find(params[:point_of_sale_id])
    end

    def set_stock
      @stock = Stock.find(params[:id])
    end
end
