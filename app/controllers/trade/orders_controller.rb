class Trade::OrdersController < ApplicationController
  before_action :authenticate_account!

  def create
    operation = Trade::Orders::Create.new(order_params)
    result = operation.call(current_account)
    redirect_to request.referrer
  end

  private

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.fetch(:order, {}).permit(:pos_id, :payment_type, items: [:variant_id, :quantity])
    end
end
