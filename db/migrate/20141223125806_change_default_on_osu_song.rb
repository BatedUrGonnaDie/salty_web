class ChangeDefaultOnOsuSong < ActiveRecord::Migration
  def change
    change_column :settings, :osu_current_song, :string, default: ""
  end
end
