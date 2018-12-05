module Operations
  module Manage
    module Products
      class Create
        attr_reader :result

        def initialize(params)
          @params = params
          @result = OpenStruct.new
        end

        def call
          @result.tap do |result|
            result.product = Product.create(title: @params[:title])
            result.variant = result.product.create_variant(@params.slice(:weight, :price))
          end
        end
      end
    end
  end
end
