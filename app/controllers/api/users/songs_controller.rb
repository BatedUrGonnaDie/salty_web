class Api::Users::SongsController < Api::ApplicationController
  before_action :set_user
  before_action :authenticate, only: [:update]

  def index
    render status: 200, json: {
      status: 200,
      mapName: @user.song.map_name,
      mapId: @user.song.map_id,
      setId: @user.song.set_id
    }
  end

  def update
    if @user.settings.update(osu_song_key: User.digest((SecureRandom.urlsafe_base64).to_s))
      render stauts: 200, json: {status: 200, new_key: @user.settings[:osu_song_key]}
    else
      render status: 400, json: {stauts: 400, error: "Error updating key."}
    end
  end
end
