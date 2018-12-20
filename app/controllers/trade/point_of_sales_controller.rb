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
    @stock = Stock.new
    redirect_to root_path, notice: 'Зміну Завершено' if request.env['REQUEST_METHOD'] == 'POST'
    @point_of_sale = PointOfSale.find(params[:point_of_sale_id])
  end

  def checkout
    Stock.create(JSON.parse(params['stock'].to_json)) if params['stock']['weight_kilogram'] != ''
    redirect_to request.referer, notice: 'Збережено'
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
