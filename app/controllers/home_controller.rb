class HomeController < ApplicationController
  def index
    if current_account && !current_account.roles.any?
      redirect_to trade_point_of_sales_path if current_account.roles.pluck(:name).include?('seller')
      redirect_to manage_products_path if current_account.roles.pluck(:name).include?('manager')
    end
  end
end
