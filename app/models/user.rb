class User < ActiveRecord::Base
  has_one :setting, foreign_key: :user_id
  has_many :commands, foreign_key: :user_id
  has_many :custom_commands, foreign_key: :user_id
  before_save {
    #bot name if blank
    #bot oauth if blank
  }
end
