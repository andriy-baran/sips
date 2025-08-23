class Manage::PointOfSalesController < ApplicationController
  before_action :authenticate_account!

  # GET /manage/point_of_sales
  def index
    @point_of_sales = PointOfSale.includes(:place)
  end

  # GET /manage/point_of_sales/1
  def show
    @result = Manage::PointOfSales::UpdateHandler.new(params)
    @point_of_sale = @result.pos
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
    @result = Manage::PointOfSales::CreateHandler.new
    @point_of_sale = @result.point_of_sale
    @point_of_sale.build_place
    @errors = @result.errors
  end

  # GET /manage/point_of_sales/1/edit
  def edit
    @result = Manage::PointOfSales::UpdateHandler.new(params.to_unsafe_h.symbolize_keys)
    @point_of_sale = @result.point_of_sale
    @errors = @result.errors
  end

  # POST /manage/point_of_sales
  handle :create do |handler|
    handler.success do
      redirect_to [:manage, handler.point_of_sale], notice: 'Point of sale was successfully created.'
    end
    handler.failure do
      @point_of_sale = handler.point_of_sale
      render :new
    end
  end

  # PATCH/PUT /manage/point_of_sales/1
  handle :update do |handler|
    handler.success do
      redirect_to [:manage, handler.pos], notice: 'Point of sale was successfully updated.'
    end

    handler.failure do
      @errors = handler.errors
      @point_of_sale = handler.point_of_sale
      render :edit
    end
  end

  # DELETE /manage/point_of_sales/1
  def destroy
    Manage::PointOfSales::UpdateHandler.new(params).point_of_sale.destroy
    redirect_to manage_point_of_sales_url, notice: 'Point of sale was successfully destroyed.'
  end
end
