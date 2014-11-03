module TwitchHelper

  def sign_in(user)
    cookies.permanent[:session] = user[:session]
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    user_session = cookies[:session]
    unless user_session == nil
      @current_user ||= User.find_by(session: user_session)
    end
  end

  def destroy
    cookies.delete(:session)
    self.current_user = nil
  end
end
