class ApplicationController < ActionController::Base
  def self.action(action_name, class_name: nil, handler: action_name, act: nil, &block)
    define_method(action_name) do
      handler_klass = handler_class_for(class_name, handler)
      handler_klass.handle(act, params) do |handler_instance|
        handler_instance.helpers = view_context
        instance_exec(handler_instance, &block)
        failure_callbacks(handler_instance)
      end
    end
  end

  private

  def handler_class_for(class_name, action_name = params[:action])
    return class_name.constantize if class_name

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

  def failure_callbacks(handler)
    handler.failure(:not_found) do
      render file: Rails.root.join('public', '404.html').to_s, status: handler.http_status
    end
  end
end
