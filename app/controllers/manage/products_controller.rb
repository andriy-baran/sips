class Manage::ProductsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /manage/products
  def index
    @products = Product.all
  end

  # GET /manage/products/1
  def show
  end

  # GET /manage/products/new
  def new
    @product = Product.new
  end

  # GET /manage/products/1/edit
  def edit
  end

  # POST /manage/products
  def create
    @operation = Manage::Products::Create.new(product_params)
    result = @operation.call

    if true
      redirect_to [:manage, result.product], notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /manage/products/1
  def update
    @operation = Manage::Products::Update.new(@product, product_params)
    result = @operation.call

    if true
      redirect_to [:manage, result.product], notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /manage/products/1
  def destroy
    @product.destroy
    redirect_to manage_products_url, notice: 'Product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.fetch(:product, {}).permit(:title, :weight, :price)
    end
end
