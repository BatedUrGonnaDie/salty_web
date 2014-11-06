class DashboardController < ApplicationController

  def to_twitch
    redirect_to "https://api.twitch.tv/kraken/oauth2/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scopes}"
  end

  def from_twitch
    oauth = HTTParty.post("https://api.twitch.tv/kraken/oauth2/token", query: full_twitch_info)['access_token']
    flash[:info] = oauth
    redirect_to dashboard_path
  end

  def dashboard
    @info = flash[:info]
    flash.discard
  end

  private
    def client_id
      client_id = ENV["dashboard_client_id"]
    end

    def client_secret
      client_secret = ENV["dashboard_client_secret"]
    end

    def redirect_uri
      redirect_uri = "https://#{request.host_with_port}/twitch/dashboard/auth"
    end

    def scopes
      scopes = "channel_editor+channel_commercial+chat_login"
    end

    def full_twitch_info
      {client_id:     client_id,
       client_secret: client_secret,
       grant_type:    'authorization_code',
       redirect_uri:  redirect_uri,
       code:          params[:code]}
    end
end
