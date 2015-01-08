class Api::SongsController < Api::ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  before_action :set_user

  def index
    render status: 200, json: {status: 200, song: "#{get_song}"}
  end

  def create
    check_for_key
    check_for_primary
    @u_settings[:osu_current_song] = params[:primary]
    if @u_settings.save
      render status: 200, json: {status: 200, song: @u_settings[:osu_current_song]}
    else
      render status: 500, json: {status: 500, error: "Unable to save song."}
    end
  end

  private
    def get_song
      @user.settings[:osu_current_song]
    end

    def check_for_key
      if params[:key].present?
        if @user.settings[:osu_song_key] != params[:key]
          render status: 401, json: {status: 401, error: "This endpoint requires a valid key."}
        else
          @u_settings
        end
      else
        render status: 400, json: {status: 400, error: "This endpoint requires the \"key\" parameter."}
      end
    end

    def check_for_primary
      if params[:primary].present?
        if params[:primary].empty?
          render status: 200
        end
      end
    end
end
