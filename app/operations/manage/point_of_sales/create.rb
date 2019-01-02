module Manage
  module PointOfSales
    class Create
      attr_reader :result

      def initialize(params)
        @params = params
        @result = OpenStruct.new
      end

      def call
        @result.tap do |result|
          result.place = Place.create(@params.slice(:city, :address))
          result.pos = PointOfSale.create(place: result.place, title: @params[:title])
          Product.all.each do |product|
            PosProductStock.create(pos_id: result.pos.id, product_id: product.id, on_hand: 0.0)
          end
        end
      end
    end
  end
end
