class OauthValidator < ActiveModel::Validator
  def validate(user_record)
    validate_user_record(user_record)
  end

  private
    def validate_user_record(user_record)
      return if user_record.bot_oauth.blank?

      if user_record.bot_oauth.start_with?("oauth:")
        user_record.bot_oauth = user_record.bot_oauth[6..-1]
      end
      response = HTTParty.get("https://api.twitch.tv/kraken/?oauth_token=#{user_record[:bot_oauth]}")
      if response.success?
        if response["token"]["valid"]
          unless response["token"]["user_name"].downcase == user_record.bot_nick.downcase
            user_record.errors[:base] << "Please enter the correct twitch name associated with this oauth."
          end
          unless response["token"]["authorization"]["scopes"].include?("chat_login")
            user_record.errors[:base] << "Please enter an oauth that has the chat_login scope."
          end
        else
          user_record.errors[:base] << "Please enter a valid oauth token."
        end
      else
        user_record.errors[:base] << "Validating the bot's oauth with Twitch failed, please try updating it later."
      end
    end
end
