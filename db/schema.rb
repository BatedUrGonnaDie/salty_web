# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_29_005706) do

  create_table "commands", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 255
    t.boolean "on"
    t.boolean "admin"
    t.integer "limit"
  end

  create_table "custom_commands", force: :cascade do |t|
    t.integer "user_id"
    t.string "trigger", limit: 255
    t.boolean "on"
    t.boolean "admin"
    t.integer "limit", default: 30
    t.string "output", limit: 255
    t.string "help_text"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "active", default: false
    t.boolean "osu_link", default: false
    t.string "osu_current_song", limit: 255, default: ""
    t.boolean "youtube_link", default: false
    t.boolean "social_active", default: false
    t.string "social_output", limit: 255
    t.integer "social_time"
    t.integer "social_messages"
    t.boolean "toobou_active", default: false
    t.integer "toobou_limit"
    t.string "toobou_trigger", limit: 255
    t.string "toobou_output", limit: 255
    t.string "osu_song_key", limit: 255
    t.boolean "sub_message_active", default: false
    t.string "sub_message_text", limit: 255, default: ""
    t.string "sub_message_resub", limit: 255, default: ""
  end

  create_table "songs", force: :cascade do |t|
    t.integer "user_id"
    t.string "map_name"
    t.string "map_id"
    t.string "set_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_songs_on_user_id"
  end

  create_table "textutils", force: :cascade do |t|
    t.integer "user_id"
    t.string "type", limit: 255
    t.boolean "reviewed"
    t.text "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "twitch_name", limit: 255
    t.integer "twitch_id"
    t.string "session", limit: 255
    t.string "email", limit: 255
    t.string "bot_nick", limit: 255
    t.string "bot_oauth", limit: 255
    t.string "srl_nick", limit: 255
    t.string "osu_nick", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "speedruncom_nick"
  end

  add_foreign_key "songs", "users"
end
