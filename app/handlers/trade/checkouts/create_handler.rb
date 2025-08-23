class Trade::Checkouts::CreateHandler < ApplicationHandler
  define do
    params do
      integer :product_id
      integer :point_of_sale_id
      float :weight_kilogram, normalize: ->(v) { v.sub(',', '.') }
    end

    query do
      depends_on :current_account, :product_stock, :point_of_sale

      find_one :product, map: { id: :product_id }, required: { message: 'Product is missing' }

      def new_stock_attrs
        {
          product_id: params[:product_id],
          pos_id: params[:point_of_sale_id],
          account_id: current_account.id,
          quantity: 1,
          weight_kilogram: weight_kilogram,
          kind: 'checkout'
        }
      end
    end

    command do
      attr_reader :stock

      def call(*)
        @stock = Stock.create(new_stock_attrs)
        total = product_stock.on_hand + weight_kilogram
        product_stock.update_column(:on_hand, total)
      end
    end
  end

  def on_success(flow)
    flow.call(flow)
  end
end
