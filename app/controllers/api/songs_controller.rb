class Api::SongsController < Api::ApplicationController

  def song_show
    user = User.find_by(twitch_name: params[:user])
    if user
      user_song = user.settings[:osu_current_song]
      if user_song == ""
        render status: 400, json: {status: 400, error: "No current song."}
      else
        render status: 200, json: {status: 200, song: "#{user_song}"}
      end
    else
      render status: 400, json: {status: 400, error: "Invalid user."}
    end
  end

  def song_update
    user_key = params[:key]
    u_setting = Settings.find_by(osu_current_song: user_to_find)
    if u_settings
      if params[:primary]
        u_setting[:osu_current_song] = params[:primary]
        render status: 200
        return
      else
        render status: 200
        return
      end
    else
      render status: 400, json: {status: 400, error: "Invalid Key."}
    end
  end
end
