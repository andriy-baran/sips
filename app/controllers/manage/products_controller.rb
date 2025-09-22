class Manage::ProductsController < ApplicationController
  before_action :authenticate_account!
  # before_action :set_product, only: %i[show edit update destroy]

  # GET /manage/products
  prepare :index do |handler|
    @products = handler.products
    @form = handler.form
  end

  # GET /manage/products/1
  prepare :show, handler: :update do |handler|
    @product = handler.product
  end

  # GET /manage/products/new
  prepare :new, handler: :create do |handler|
    @product = handler.product
    @product.variants.build
    @form = handler.form
  end

  # GET /manage/products/1/edit
  prepare :edit, handler: :update do |handler|
    @product = handler.product
    @form = handler.form
  end

  # POST /manage/products
  handle :create do |handler|
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
  handle :update do |handler|
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
  handle :destroy, handler: :update do |handler|
    handler.product.destroy
    redirect_to manage_products_url, notice: 'Product was successfully destroyed.'
  end
end
