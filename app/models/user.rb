class User < ActiveRecord::Base
  has_one   :settings, foreign_key: :twitch_id
  has_many  :commands, foreign_key: :twitch_id
  has_many  :custom_commands, foreign_key: :twitch_id
  before_save {
    #bot name if blank
    #bot oauth if blank
  }
end
