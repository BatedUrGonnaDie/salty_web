class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.integer :twitch_id
      t.index :twitch_id
      t.json :commands, default: {on: false, admin: false, limit: 15}
      t.json :wr, default: {on: false, admin: false, limit: 15}
      t.json :leaderboard, default: {on: false, admin: false, limit: 15}
      t.json :splits, default: {on: false, admin: false, limit: 15}
      t.json :race, default: {on: false, admin: false, limit: 15}
      t.json :quote, default: {on: false, admin: false, limit: 15}
      t.json :addquote, default: {on: false, admin: false, limit: 15}
      t.json :pun, default: {on: false, admin: false, limit: 15}
      t.json :addpun, default: {on: false, admin: false, limit: 15}
      t.json :song, default: {on: false, admin: false, limit: 15}
      t.json :rank, default: {on: false, admin: false, limit: 15}
      t.json :rank, default: {on: false, admin: false, limit: 15}
      t.json :vote, default: {on: false, admin: false, limit: 15}
      t.json :runes, default: {on: false, admin: false, limit: 15}
      t.json :masteries, default: {on: false, admin: false, limit: 15}
    end
  end
end
