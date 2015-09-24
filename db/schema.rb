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

ActiveRecord::Schema.define(version: 20150516082051) do

  create_table "commands", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.boolean "on"
    t.boolean "admin"
    t.integer "limit"
  end

  create_table "custom_commands", force: :cascade do |t|
    t.integer "user_id"
    t.string  "trigger"
    t.boolean "on"
    t.boolean "admin"
    t.integer "limit",   default: 30
    t.string  "output"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "active",             default: false
    t.boolean "osu_link",           default: false
    t.string  "osu_current_song",   default: ""
    t.boolean "youtube_link",       default: false
    t.boolean "social_active",      default: false
    t.string  "social_output"
    t.integer "social_time"
    t.integer "social_messages"
    t.boolean "toobou_active",      default: false
    t.integer "toobou_limit"
    t.string  "toobou_trigger"
    t.string  "toobou_output"
    t.string  "osu_song_key"
    t.boolean "sub_message_active", default: false
    t.string  "sub_message_text",   default: ""
    t.string  "sub_message_resub",  default: ""
    t.boolean "voting_active",      default: false
    t.boolean "voting_mods",        default: false
  end

  create_table "textutils", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.boolean  "reviewed"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "twitch_name"
    t.integer  "twitch_id"
    t.string   "session"
    t.string   "email"
    t.string   "bot_nick"
    t.string   "bot_oauth"
    t.string   "srl_nick"
    t.string   "summoner_name"
    t.string   "osu_nick"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "speedruncom_nick"
  end

end
