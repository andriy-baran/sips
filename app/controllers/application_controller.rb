class ApplicationController < ActionController::Base
  private

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
