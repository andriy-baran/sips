class Manage::AccountsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /manage/accounts
  def index
    @accounts = Account.all
  end

  def new
    @account  = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      @account.add_role(params[:role])
      redirect_to manage_accounts_path
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @account.update(account_params)
      @account.roles.destroy_all
      @account.add_role(params[:role])
      redirect_to manage_accounts_path
    else
      render :new
    end
  end

  # DELETE /manage/accounts/1
  def destroy
    @account.destroy
    redirect_to manage_accounts_url, notice: 'Account was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:email, :full_name, :phone, :password, :password_confirmation, :pos_id)
  end
end
