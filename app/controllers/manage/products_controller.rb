class Manage::ProductsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /manage/products
  def index
    @products = Product.all.preload(:variant)
  end

  # GET /manage/products/1
  def show
  end

  # GET /manage/products/new
  def new
    @product = Product.new
    @variant = @product.build_variant
    @errors = {}
  end

  # GET /manage/products/1/edit
  def edit
    @errors = {}
  end

  # POST /manage/products
  def create
    result = Manage::Products::CreateHandler.handle(input: product_params)

    if result.valid?
      redirect_to [:manage, result.new_product], notice: 'Product was successfully created.'
    else
      @product = result.new_product
      @variant = result.new_variant
      @errors = result.errors
      render :new, status: result.status
    end
  end

  # PATCH/PUT /manage/products/1
  def update
    result = Manage::Products::UpdateHandler.handle(input: product_params)

    if result.valid?
      redirect_to [:manage, result.product], notice: 'Product was successfully updated.'
    else
      @errors = result.errors
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
      params.fetch(:product, {}).permit(:id, :title, :weight, :price)
    end
end
