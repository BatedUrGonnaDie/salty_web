class AddtoUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :bot_nick, default: ""
      t.string :bot_oauth, default: ""
      t.string :srl_nick, default: ""
      t.string :summoner_name, default: ""
      t.boolean :youtube_link, default: false
      t.json :osu, default: {osu_nick: "", song_link: false}
      t.json :social, default: {on: false, text: "", time: 0, messages: 0}
      t.json :toobou, default: {on: false, limit: 120, trigger: "toobou", insult: "I think you トーボウ, #learnmoonrunes"}
      t.json :custom, default: {on: false, triggers: [], output: [], admins: [], limits: []}
    end
  end
end
