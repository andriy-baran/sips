class Manage::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /manage/accounts
  def index
    @accounts = Account.all
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

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.fetch(:account, {}).permit(:title, :weight, :price)
    end
end
