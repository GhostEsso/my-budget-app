class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    allowed_params = %i[name email password password_confirmation current_password]

    devise_parameter_sanitizer.permit(:sign_up, keys: allowed_params)
    devise_parameter_sanitizer.permit(:sign_in, keys: allowed_params.first(2))
    devise_parameter_sanitizer.permit(:account_update, keys: allowed_params)
  end
end
