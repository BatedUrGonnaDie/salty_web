class OauthValidator < ActiveModel::Validator
  def validate(user_record)
    validate_user_record(user_record)
  end

  private

  LOGIN_SCOPE = 'chat_login'.freeze
  OTHER_SCOPE = [
    'channel:moderate',
    'channel_editor',
    'chat:edit',
    'chat:read',
    'whispers:edit',
    'whispers:read'
  ].freeze

  def validate_user_record(user_record)
    return if user_record.bot_oauth.blank?

    user_record.bot_oauth = user_record.bot_oauth[6..-1] if user_record.bot_oauth.start_with?('oauth:')
    response = HTTParty.get(
      "https://api.twitch.tv/kraken/?oauth_token=#{user_record[:bot_oauth]}",
      headers: {
        'Accept': 'application/vnd.twitchtv.v5+json',
        'Client-ID': ENV['salty_client_id']
      }
    )

    unless response.success?
      user_record.errors[:base] << "Validating the bot's oauth with Twitch failed, please try updating it later."
      return
    end

    unless response['token']['valid']
      user_record.errors[:base] << 'The entered token was not valid on Twitch'
      return
    end

    unless response['token']['user_name'].downcase == user_record.bot_nick.downcase
      user_record.errors[:base] << 'Please enter the correct twitch name associated with this oauth.'
      return
    end

    token_scopes = response['token']['authorization']['scopes']

    unless token_scopes.include?(LOGIN_SCOPE) || OTHER_SCOPE.all? { |scope| token_scopes.include?(scope) }
      user_record.errors[:base] << 'Please enter an oauth that has the chat_login scope.'
      return
    end
  end
end
