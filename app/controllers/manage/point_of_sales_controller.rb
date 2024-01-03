class Manage::PointOfSalesController < ApplicationController
  before_action :authenticate_account!
  before_action :set_point_of_sale, only: [:show, :edit, :update, :destroy]

  # GET /manage/point_of_sales
  def index
    @point_of_sales = PointOfSale.includes(:place)
  end

  # GET /manage/point_of_sales/1
  def show
    @stock_data = { labels: [], datasets: [] }
    dataset = { label: '', data: [], background_color: [] }
    Product.all.each do |product|
      @stock_data[:labels] << product.title
      actual_stock = ProductStocksQuery.new(product_id: product.id, pos_id: @point_of_sale.id).all.first
      dataset[:background_color] << "rgba(#{rand(255)}, #{rand(255)}, #{rand(255)}, 0.4)"
      dataset[:data] << (actual_stock.nil? ? 0.0 : actual_stock.on_hand)
    end
    @stock_data[:datasets] << dataset

    @sell_data = { labels: [], datasets: [] }
    dataset = { label: '', data: [], background_color: "rgba(#{rand(255)}, #{rand(255)}, #{rand(255)}, 0.4)" }
    30.times.to_a.reverse.each do |d|
      time =  Time.zone.now - d.days
      @sell_data[:labels] << I18n.l(time, format: '%d/%m')
      pos_sellings = PosCashQuery.new(on_day: time, pos_id: @point_of_sale.id, last_days: 30).all
      dataset[:data] << (pos_sellings.nil? ? 0.0 : pos_sellings.sum(&:sold_amount))
    end
    @sell_data[:datasets] << dataset
  end

  # GET /manage/point_of_sales/new
  def new
    @point_of_sale = PointOfSale.new
    @point_of_sale.build_place
  end

  # GET /manage/point_of_sales/1/edit
  def edit
  end

  # POST /manage/point_of_sales
  def create
    result = Manage::PointOfSales::CreateHandler.handle(input: point_of_sale_params)

    if result.success?
      redirect_to [:manage, result.new_pos], notice: 'Point of sale was successfully created.'
    else
      @point_of_sale = result.new_pos
      @point_of_sale.errors.merge!(result.errors)
      render :new
    end
  end

  # PATCH/PUT /manage/point_of_sales/1
  def update
    @operation = Manage::PointOfSales::Update.new(@point_of_sale, point_of_sale_params)
    result = @operation.call

    if true
      redirect_to [:manage, result.pos], notice: 'Point of sale was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /manage/point_of_sales/1
  def destroy
    @point_of_sale.destroy
    redirect_to manage_point_of_sales_url, notice: 'Point of sale was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point_of_sale
      @point_of_sale = PointOfSale.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def point_of_sale_params
      params.fetch(:point_of_sale, {}).to_unsafe_h#.permit(:title, place_attributes: [:city, :address])
    end
end
