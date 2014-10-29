module TwitchHelper

  def sign_in(user)
    cookies.permanent[:name] = user[:twitch_name]
    cookies.permanent[:oauth_hash] = user[:oauth_hash]
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    user_hash = cookies[:oauth_hash]
    user_name = cookies[:name]
    unless user_hash == nil
      @current_user ||= User.find_by(oauth_hash: user_hash, twitch_name: user_name)
    end
  end

  def destroy
    cookies.delete(:name)
    cookies.delete(:oauth_hash)
    self.current_user = nil
  end
end
