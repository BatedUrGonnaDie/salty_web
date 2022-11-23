class AddOsuSongKeyToSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :settings, :osu_song_key, :string
  end
end
