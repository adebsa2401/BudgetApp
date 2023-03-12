class ApplicationController < ActionController::Base
  before_action :configure_signup_params, only: [:create]

  protected

  def configure_signup_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
