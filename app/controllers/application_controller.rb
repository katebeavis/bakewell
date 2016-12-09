class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :version_number
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || recipes_path
  end

  def version_number
    @version_number = 0.1
  end
  
end
