module TwitchHelper

  def sign_in(user)
    cookies.permanent[:name] = user[:twitch_name]
    cookies.permanent[:oauth] = user[:oauth]
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    user_oauth = cookies[:oauth]
    user_name = cookies[:name]
    unless user_oauth == nil
      @current_user ||= User.find_by(oauth: user_oauth, twitch_name: user_name)
    end
  end

  def destroy
    cookies.delete(:name)
    cookies.delete(:oauth)
    self.current_user = nil
  end
end
