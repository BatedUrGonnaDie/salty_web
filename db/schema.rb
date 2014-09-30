# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140928220527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commands", force: true do |t|
    t.integer "twitch_id"
    t.json    "commands",    default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "wr",          default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "leaderboard", default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "splits",      default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "race",        default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "quote",       default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "addquote",    default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "pun",         default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "addpun",      default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "song",        default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "rank",        default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "vote",        default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "runes",       default: {"on"=>false, "admin"=>false, "limit"=>15}
    t.json    "masteries",   default: {"on"=>false, "admin"=>false, "limit"=>15}
  end

  add_index "commands", ["twitch_id"], name: "index_commands_on_twitch_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "twitch_name"
    t.integer  "twitch_id"
    t.string   "oauth"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bot_nick",      default: ""
    t.string   "bot_oauth",     default: ""
    t.string   "srl_nick",      default: ""
    t.string   "summoner_name", default: ""
    t.boolean  "youtube_link",  default: false
    t.json     "osu",           default: {"osu_nick"=>"", "song_link"=>false}
    t.json     "social",        default: {"on"=>false, "text"=>"", "time"=>0, "messages"=>0}
    t.json     "toobou",        default: {"on"=>false, "limit"=>120, "trigger"=>"toobou", "insult"=>"I think you トーボウ, #learnmoonrunes"}
    t.json     "custom",        default: {"on"=>false, "triggers"=>[], "output"=>[], "admins"=>[], "limits"=>[]}
  end

end
