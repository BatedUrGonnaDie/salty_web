class Api::Users::SongsController < Api::ApplicationController
  before_action :set_user
  before_action :authenticate, only: [:update]
  before_action :check_for_key, only: [:create]
  before_action :check_for_primary, only: [:create]

  def index
    render status: 200, json: {status: 200, song: "#{get_song}"}
  end

  def create
    # Most programs require it to be POST action
    if @settings.update(osu_current_song: params[:primary])
      render status: 200, json: {status: 200, song: @settings[:osu_current_song]}
    else
      render status: 400, json: {status: 400, error: "Unable to save song."}
    end
  end

  def update
    if @user.settings.update(osu_song_key: User.digest((SecureRandom.urlsafe_base64).to_s))
      render stauts: 200, json: {status: 200, new_key: @user.settings[:osu_song_key]}
    else
      render status: 400, json: {stauts: 400, error: "Error updating key."}
    end
  end

  private
    def get_song
      @user.settings[:osu_current_song]
    end

    def check_for_key
      if params[:key].present?
        if @user.settings[:osu_song_key] != params[:key] && @user.settings[:osu_song_key] != nil
          render status: 401, json: {status: 401, error: "This endpoint requires a valid key."}
          return
        else
          @settings = @user.settings
        end
      else
        render status: 400, json: {status: 400, error: "This endpoint requires the \"key\" parameter."}
        return
      end
    end

    def check_for_primary
      if params[:primary].present?
        if params[:primary].empty?
          render status: 200, json: {status: 200} and return
        end
      else
        render status: 200, json: {status: 200} and return
      end
    end
end
