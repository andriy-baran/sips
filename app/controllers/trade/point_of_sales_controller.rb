class Trade::PointOfSalesController < ApplicationController
  before_action :authenticate_account!
  before_action :set_point_of_sale, only: [:show, :report, :checkout]

  def index
    @point_of_sales = PointOfSale.all
  end
  # GET /trade/point_of_sales/1
  def show
    @products = Product.includes(:variant).all
  end

  def report
    @reports = Stock.includes(:product)
      .where('stocks.pos_id = ?', params[:id])
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

  def checkout
    @product = Product.find_by(id: params[:product_id])
    if @product
      attrs = {
        product_id: params[:product_id],
        pos_id: params[:id],
        account_id: current_account.id,
        quantity: 1,
        weight_kilogram: params[:weight_kilogram].sub(',', '.').to_f,
        kind: 'checkout'
      }
      @stock = Stock.create(attrs)
      render partial: :checkout, layout: false
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point_of_sale
      @point_of_sale = PointOfSale.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def point_of_sale_params
      params.fetch(:point_of_sale, {}).permit(:title, :city, :address)
    end
end
