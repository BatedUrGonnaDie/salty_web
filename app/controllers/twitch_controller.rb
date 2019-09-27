class TwitchController < ApplicationController

  def to_twitch
    redirect_to "https://id.twitch.tv/oauth2/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=user_read"
  end

  def from_twitch
    # raise
    twitch_response = HTTParty.post("https://id.twitch.tv/oauth2/token", query: full_twitch_info)
    if twitch_response.success?
      oauth = twitch_response['access_token']
      user_data = HTTParty.get("https://api.twitch.tv/kraken/user?oauth_token=#{oauth}", headers: {'Accept': 'application/vnd.twitchtv.v5+json'})
      unless user_data.success?
        flash[:danger] = "There was an error retrieving data from twitch."
        redirect_to(salty_path) && return
      end
    else
      flash[:danger] = "There was an error retrieving data from twitch."
      redirect_to(salty_path) && return

    end

    @user = User.find_by(twitch_id: user_data['_id'])

    if @user.nil?
      @user = User.new(email: user_data['email'], twitch_id: user_data['_id'], twitch_name: user_data['name'])
      new_user = true
    end

    @user.session = User.digest((SecureRandom.urlsafe_base64).to_s)

    if @user.save
      @user.create_settings! if new_user
      sign_in @user
      redirect_to(salty_path)
    else
      flash[:danger] = @user.errors
      redirect_to(root_path)
    end
  end

  def sign_out
    destroy
    flash[:success] = "Signed out"
    redirect_to(root_path)
  end

  private
    def client_id
      client_id = ENV["salty_client_id"]
    end

    def client_secret
      client_secret = ENV["salty_client_secret"]
    end

    def redirect_uri
      if !Rails.env.development?
        redirect_uri = "https://#{request.host_with_port}/twitch/salty/auth"
      else
        redirect_uri = "http://#{request.host_with_port}/twitch/salty/auth"
      end
    end

    def full_twitch_info
      {client_id:     client_id,
       client_secret: client_secret,
       grant_type:    'authorization_code',
       redirect_uri:  redirect_uri,
       code:          params[:code]}
    end
end
