class Trade::OrdersController < ApplicationController
  def create
    operation = Operations::Trade::Orders::Create.new(order_params)
    result = operation.call(OpenStruct.new(id: 1))
    redirect_to request.referrer
  end

  private

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.fetch(:order, {}).permit(:pos_id, :payment_type, items: [:variant_id, :quantity])
    end
end
