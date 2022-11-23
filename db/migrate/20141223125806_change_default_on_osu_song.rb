class ChangeDefaultOnOsuSong < ActiveRecord::Migration[4.2]
  def change
    change_column :settings, :osu_current_song, :string, default: ""
  end
end
