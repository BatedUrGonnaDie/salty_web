class AddOsuSongKeyToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :osu_song_key, :string
  end
end
