class Manage::PointOfSalesController < ApplicationController
  before_action :set_point_of_sale, only: [:show, :edit, :update, :destroy]

  # GET /manage/point_of_sales
  def index
    @point_of_sales = PointOfSale.includes(:place)
  end

  # GET /manage/point_of_sales/1
  def show
  end

  # GET /manage/point_of_sales/new
  def new
    @point_of_sale = PointOfSale.new
  end

  # GET /manage/point_of_sales/1/edit
  def edit
  end

  # POST /manage/point_of_sales
  def create
    @operation = ::Operations::Manage::PointOfSales::Create.new(point_of_sale_params)
    result = @operation.call

    if true
      redirect_to [:manage, result.pos], notice: 'Point of sale was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /manage/point_of_sales/1
  def update
    @operation = ::Operations::Manage::PointOfSales::Update.new(@point_of_sale, point_of_sale_params)
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
      params.fetch(:point_of_sale, {}).permit(:title, :city, :address)
    end
end
