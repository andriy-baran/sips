class Manage::ProductsController < ApplicationController
  before_action :authenticate_account!
  # before_action :set_product, only: %i[show edit update destroy]

  # GET /manage/products
  def index
    @products = Product.includes(:variants)
  end

  # GET /manage/products/1
  def show
    @presenter = Manage::Products::UpdateHandler.new(params.to_unsafe_h.symbolize_keys)
    @product = @presenter.product
  end

  # GET /manage/products/new
  ask :new, handler: :create do |form|
    @form = form
    @errors = ActiveModel::Errors.new(form)
  end

  # GET /manage/products/1/edit
  ask :edit, handler: :update do |form|
    @form = form
    @product = form.model
    @errors = ActiveModel::Errors.new(form)
  end

  # POST /manage/products
  handle :create do |handler|
    handler.success do
      redirect_to [:manage, handler.product], notice: 'Product was successfully created.'
    end

    handler.failure do
      @errors = handler.errors
      render :new
    end
  end

  # PATCH/PUT /manage/products/1
  handle :update do |handler|
    handler.success do
      redirect_to [:manage, handler.product], notice: 'Product was successfully updated.'
    end

    handler.failure do
      @errors = handler.errors
      render :edit
    end
  end

  # DELETE /manage/products/1
  def destroy
    Manage::Products::UpdateHandler.new(params).product.destroy
    redirect_to manage_products_url, notice: 'Product was successfully destroyed.'
  end
end
