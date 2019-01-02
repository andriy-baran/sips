module Manage
  module Products
    class Update
      attr_reader :result

      def initialize(product, params)
        @product = product
        @params = params
        @result = OpenStruct.new
      end

      def call
        @result.tap do |result|
          @product.update(title: @params[:title])
          @product.variant.update(@params.slice(:weight, :price))
          result.product = @product
        end
      end
    end
  end
end
