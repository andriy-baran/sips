class Manage::DashboardController < ApplicationController
  def index
    # Dashboard data can be added here
    # For now, we'll use existing analytics data
    @sold_today = 0
    @number_today = 0
    @sell_data = []
    @sell_data2 = []
    @stocks = []
  end
end
