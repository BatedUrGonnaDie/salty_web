class User < ActiveRecord::Base
  has_one :command, foreign_key: :twitch_id
  before_save {
    #bot name if blank
    #bot oauth if blank
  }
end
