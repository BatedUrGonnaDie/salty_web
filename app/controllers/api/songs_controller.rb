class Api::SongsController < Api::ApplicationController
  before_action :set_user
  before_action :check_key
  before_action :filter_request
  before_action :set_song

  def create
    if @song.update(map_name: params[:mapName], map_id: params[:mapID], set_id: params[:mapSetID])
      render status: 200, json: { status: 200 }
    else
      render status: 400, json: { status: 400, error: 'Unable to save song' }
    end
  end

  private

  def set_user
    @user = User.includes(:song, :settings).find_by(osu_nick: params[:user])
    render status: 404, json: { status: 404, error: 'Invalid user' } unless @user
  end

  def check_key
    render status: 403, json: { status: 403 } unless @user.settings[:osu_song_key] == params[:key]
  end

  def filter_request
    true
    # render status: 200, json: { status: 200 } if params[:userAction] == 'Listening'
  end

  def set_song
    @song = @user.song || Song.new(user: @user)
  end
end
