class User < ActiveRecord::Base
  has_one   :settings
  has_many  :commands
  has_many  :custom_commands
  has_many  :quotes
  has_many  :puns
  accepts_nested_attributes_for :settings
  accepts_nested_attributes_for :commands
  accepts_nested_attributes_for :custom_commands
  accepts_nested_attributes_for :quotes
  accepts_nested_attributes_for :puns
  before_save {
    #bot name if blank
    #bot oauth if blank
  }

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def commands
    {
      commands:     Command.new(name: "commands",     on: false, admin: false, limit: 30),
      quote:        Command.new(name: "quote",        on: false, admin: false, limit: 30),
      add_quote:    Command.new(name: "add_quote",    on: false, admin: false, limit: 30),
      pun:          Command.new(name: "pun",          on: false, admin: false, limit: 30),
      add_pun:      Command.new(name: "add_pun",      on: false, admin: false, limit: 30),
      vote:         Command.new(name: "vote",         on: false, admin: false, limit: 30),
      uptime:       Command.new(name: "uptime",       on: false, admin: false, limit: 30),
      highlight:    Command.new(name: "highlight",    on: false, admin: false, limit: 30),

      wr:           Command.new(name: "wr",           on: false, admin: false, limit: 30),
      leaderboard:  Command.new(name: "leaderboard",  on: false, admin: false, limit: 30),
      splits:       Command.new(name: "splits",       on: false, admin: false, limit: 30),
      race:         Command.new(name: "race",         on: false, admin: false, limit: 30),

      song:         Command.new(name: "song",         on: false, admin: false, limit: 30),
      rank:         Command.new(name: "rank",         on: false, admin: false, limit: 30),

      runes:        Command.new(name: "runes",        on: false, admin: false, limit: 30),
      masteries:    Command.new(name: "masteries",    on: false, admin: false, limit: 30)
    }.merge(super.map{ |command| {command.name.to_sym => command} }.inject(:merge) || {}).values
  end
end
