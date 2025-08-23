class ApplicationController < ActionController::Base
  def self.handle(action_name, class_name: nil, &block)
    define_method(action_name) do
      handler_klass = handler_class(class_name)
      handler_klass.handle(params) do |handler|
        instance_exec(handler, &block)
      end
    end
  end

  def self.ask(action_name, handler: nil, class_name: nil, &block)
    define_method(action_name) do
      handler_klass = handler_class(class_name, handler)
      handler_klass.ask(params) do |form|
        instance_exec(form, &block)
      end
    end
  end

  private

  def handler_class(class_name = nil, action_name = params[:action])
    return class_name if class_name

    "#{[params[:controller], action_name].compact.join('/')}_handler".classify.constantize
  end

  def after_sign_in_path_for(resource)
    if resource.has_role?(:manager)
      request.env['omniauth.origin'] || stored_location_for(resource) || manage_analytics_path
    elsif resource.has_role?(:seller)
      request.env['omniauth.origin'] || stored_location_for(resource) || trade_point_of_sale_path(resource.pos_id)
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
  end
end
