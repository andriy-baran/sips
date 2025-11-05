class Manage::AccountsController < ApplicationController
  before_action :authenticate_account!

  # GET /manage/accounts
  action :index do |handler|
    @accounts = handler.accounts
    @form = handler.form
  end

  # GET /manage/accounts/1
  action :show, handler: :update do |handler|
    @account = handler.account
  end

  # GET /manage/accounts/new
  action :new, handler: :create do |handler|
    @account = handler.account
    @form = handler.form
    @errors = handler.errors
  end

  # GET /manage/accounts/1/edit
  action :edit, handler: :update do |handler|
    @account = handler.account
    @form = handler.form
    @errors = handler.errors
  end

  # POST /manage/accounts
  action :create do |handler|
    handler.success do
      redirect_to [:manage, handler.account], notice: 'Account was successfully created.'
    end

    handler.failure do
      @account = handler.account
      @form = handler.form
      @errors = handler.errors
      render :new
    end
  end

  # PATCH/PUT /manage/accounts/1
  action :update do |handler|
    handler.success do
      redirect_to [:manage, handler.account], notice: 'Account was successfully updated.'
    end

    handler.failure do
      @form = handler.form
      @account = handler.account
      @errors = handler.errors
      render :edit
    end
  end

  # DELETE /manage/accounts/1
  action :destroy, handler: :update do |handler|
    redirect_to manage_accounts_url, notice: 'Account was successfully destroyed.'
  end
end
