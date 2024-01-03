class Trade::Checkouts::CreateHandler < ApplicationHandler
  define do
    params do
      attribute :product_id, integer
      attribute :point_of_sale_id, integer
      attribute :weight_kilogram, float
    end

    query do
      attr_accessor :current_account, :stock, :product_stock

      find_one :product, map: { id: :product_id }
      find_one :point_of_sale, map: { id: :point_of_sale_id }

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

      validate do
        errors.add(:not_found, 'Product is missing') if product.nil?
        errors.add(:not_found, 'PoS is missing') if point_of_sale.nil?
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
