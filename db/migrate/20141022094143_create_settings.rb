class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.boolean :active, default: false
      t.boolean :osu_link, default: false
      t.string  :osu_current_song
      t.boolean :youtube_link, default: false
      t.boolean :social_active, default: false
      t.string :social_output
      t.integer :social_time
      t.integer :social_messages
      t.boolean :toobou_active, default: false
      t.integer :toobou_limit
      t.string :toobou_trigger
      t.string :toobou_output
    end
  end
end
