class Trade::CheckoutsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_point_of_sale
  before_action :set_pos_product_stock, on: :create
  before_action :set_stock, only: [:edit, :update]

  def index
    @reports = Stock.includes(:product)
      .on_day
      .by_pos_id(@point_of_sale.id)
      .checkouted
      .where('stocks.quantity = 1')
      .group('stocks.product_id, stocks.id')
    if @reports.any?
      @products = Product.where('id NOT IN (?)', @reports.map(&:product_id))
    else
      @products = Product.all
    end
  end

  def create
    result = Trade::Checkouts::CreateHandler.handle(input: params) do |i|
      i.query.current_account = current_account
    end
    # @product = Product.find_by(id: params[:product_id])
    binding.pry
    if @product
      # weight_kilogram = params[:weight_kilogram].sub(',', '.').to_f
      # attrs = {
      #     product_id: params[:product_id],
      #     pos_id: params[:point_of_sale_id],
      #     account_id: current_account.id,
      #     quantity: 1,
      #     weight_kilogram: weight_kilogram,
      #     kind: 'checkout'
      # }
      # @stock = Stock.create(attrs)
      # @product_stock.update_column(:on_hand, weight_kilogram)
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
    def set_pos_product_stock
      @product_stock = PosProductStock.where(pos_id: params[:point_of_sale_id], product_id: params[:product_id]).first_or_create
    end

    def set_point_of_sale
      @point_of_sale = PointOfSale.find(params[:point_of_sale_id])
    end

    def set_stock
      @stock = Stock.find(params[:id])
    end
end
