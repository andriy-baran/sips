class Trade::PointOfSalesController < ApplicationController
  before_action :authenticate_account!
  before_action :set_point_of_sale, only: [:show]

  def index
    @point_of_sales = PointOfSale.all
  end
  # GET /trade/point_of_sales/1
  def show
    @products = Product.includes(:variant).all
  end

  def complete_change
    @point_of_sale = PointOfSale.find(params[:point_of_sale_id])
    return unless @point_of_sale
    all_weight = current_account.stocks.sold_today.sum { |s| s.weight_kilogram }
    stock = current_account.stocks.create(weight_kilogram: all_weight, kind: 'checkout' )
    stock.save ? redirect_to(trade_point_of_sale_path(@point_of_sale), notice: 'Зміна завершена') : redirect_to(trade_point_of_sale_path(@point_of_sale))
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
