class Trade::PointOfSalesController < ApplicationController
  before_action :set_point_of_sale, only: [:show]

  # GET /trade/point_of_sales/1
  def show
    @products = Product.all
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
