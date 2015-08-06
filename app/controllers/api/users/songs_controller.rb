class Api::Users::SongsController < Api::ApplicationController
  before_action :set_user

  def index
    render status: 200, json: {status: 200, song: "#{get_song}"}
  end

  def create
    check_for_key
    check_for_primary
    @settings[:osu_current_song] = params[:primary]
    if @settings.save
      render status: 200, json: {status: 200, song: @settings[:osu_current_song]}
    else
      render status: 400, json: {status: 400, message: "Unable to save song."}
    end
  end

  private
    def get_song
      @user.settings[:osu_current_song]
    end

    def check_for_key
      if params[:key].present?
        if @user.settings[:osu_song_key] != params[:key]
          render status: 401, json: {status: 401, message: "This endpoint requires a valid key."}
          return
        else
          @settings = @user.settings
        end
      else
        render status: 400, json: {status: 400, message: "This endpoint requires the \"key\" parameter."}
        return
      end
    end

    def check_for_primary
      if params[:primary].present?
        if params[:primary].empty?
          render status: 200, json: {status: 200}
          return
        end
      else
        render status: 200, json: {status: 200}
        return
      end
    end
end
