class Manage::Products::CreateHandler < ApplicationHandler
  define do
    params Manage::Products::CreateParams

    query Manage::Products::CreateQuery

    command Manage::Products::CreateCommand
  end

  def on_exception(e)
    output.errors.add(:unprocessable_entity, e.message)
  end

  def on_success(flow)
    flow.call(flow)
  end
end
