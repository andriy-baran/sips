class Manage::Products::CreateHandler < ApplicationHandler
  define do
    params Params
    query Query
    command Command
  end

  def on_success(flow)
    flow.call(flow)
  end
end
