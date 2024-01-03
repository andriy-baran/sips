class Manage::PointOfSales::CreateHandler < ApplicationHandler
  define do
    params Params

    query do
      memoize def new_pos
        ::PointOfSale.new(params.to_h)
      end
    end

    command Command
  end

  def on_success(flow)
    flow.call(flow)
  end

  def on_failure(flow)

  end
end
