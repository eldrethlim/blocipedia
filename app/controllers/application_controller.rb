class ApplicationController < ActionController::Base
  
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ (/\/users/ || /\/subscriptions/)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :username << :country << :address << :postcode << :state
  end
end