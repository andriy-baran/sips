module Trade
  module Orders
    class Create
      attr_reader :result

      def initialize(params)
        @params = params
        @result = OpenStruct.new
        @items  = Create::ItemSet.from_hashes(params[:items])
      end

      def call(account)
        @result.tap do |result|
          @items.each_with_variant do |item, variant|
            attrs = {
              product_id: variant.product_id,
              pos_id: @params[:pos_id],
              account_id: account.id,
              quantity: item.quantity,
            }
            track_money(attrs.merge(price_uah: variant.price.to_d, kind: @params[:payment_type]))
            track_weight(attrs.merge(weight_kilogram: variant.weight.convert_to('kilogram'), kind: 'sell'))
          end
          result.success = true
        end
      end

      private

      def track_money(attrs)
        Cashbox.create(attrs)
      end

      def track_weight(attrs)
        Stock.create(attrs)
      end
    end
  end
end
