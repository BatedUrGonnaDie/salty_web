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

  def send_update
    if Rails.env.development?
      ip = "localhost"
    else
      ip = ENV["salty_ip_address"]
    end
    sock = TCPSocket.new(ip, 6666)
    sock.write(ENV["salty_web_secret"])
    sock.write JSON.generate({user_id: @user.id})
    sock.close()
    return true
  rescue Errno::ETIMEDOUT, Errno::ECONNREFUSED
    return false
  end

end
