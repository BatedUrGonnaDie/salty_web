class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl if !Rails.env.development?

  include TwitchHelper

  before_action :remove_www

  def remove_www
    redirect_to(subdomain: nil) if request.subdomain == 'www'
  end
  #"borrowed" from glacials/splits-io
end
