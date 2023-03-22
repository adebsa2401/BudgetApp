class ApplicationController < ActionController::Base
  before_action :configure_signup_params, only: [:create], if: :devise_controller?

  protected

  def registration_controller?
    devise_controller? && resource_name == :user && action_name == 'create'
  end

  def configure_signup_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
