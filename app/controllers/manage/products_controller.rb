class Manage::ProductsController < ApplicationController
  before_action :authenticate_account!
  # before_action :set_product, only: %i[show edit update destroy]

  # GET /manage/products
  action :index do |handler|
    @products = handler.products
    @form = handler.form
  end

  # GET /manage/products/1
  action :show, handler: :update do |handler|
    @product = handler.product
  end

  # GET /manage/products/new
  action :new, handler: :create do |handler|
    @product = handler.product
    # @product.variants.build
    @form = handler.form
  end

  # GET /manage/products/1/edit
  action :edit, handler: :update do |handler|
    @product = handler.product
    @form = handler.form
  end

  # POST /manage/products
  action :create do |handler|
    handler.success do
      redirect_to [:manage, handler.product], notice: 'Product was successfully created.'
    end

    handler.failure do
      @product = handler.product
      @form = handler.form
      render :new
    end
  end

  # PATCH/PUT /manage/products/1
  action :update do |handler|
    handler.success do
      redirect_to [:manage, handler.product], notice: 'Product was successfully updated.'
    end

    handler.failure do
      @form = handler.form
      @product = handler.product
      render :edit
    end
  end

  # DELETE /manage/products/1
  action :destroy, handler: :update do |handler|
    handler.destroy
    redirect_to manage_products_url, notice: 'Product was successfully destroyed.'
  end
end
