class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitch_name
      t.integer :twitch_id
      t.string :oauth
      t.string :session
      t.string :email
      t.string :bot_nick
      t.string :bot_oauth
      t.string :srl_nick
      t.string :summoner_name
      t.string :osu_nick
      t.integer :splits_io_id
      t.timestamps
    end
  end
end
