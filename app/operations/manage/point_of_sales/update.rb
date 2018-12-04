module Operations
  module Manage
    module PointOfSales
      class Update
        attr_reader :result

        def initialize(pos, params)
          @pos = pos
          @params = params
          @result = OpenStruct.new
        end

        def call
          @result.tap do |result|
            @pos.update(title: @params[:title])
            @pos.place.update(@params.slice(:city, :address))
            result.pos = @pos
          end
        end
      end
    end
  end
end
