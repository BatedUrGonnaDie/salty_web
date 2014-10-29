class UsersController < ApplicationController
  def salty
  end

  def update
    user = User.find_by(twitch_name: params[:user][:twitch_name])

    user.update_attributes(user_params)

    flash[:success] = "Settings Saved"
    redirect_to salty_path
  end

  private

    def user_params
      params.require(:user).permit( {:settings => [:id, :active, :youtube_link, :osu_song_link,
                                    :social_active, :social_output, :social_time, :social_messages,
                                    :toobou_active, :toobou_limit, :toobou_trigger, :toobou_output]},
                                    :twitch_name, :bot_nick, :bot_oauth, :srl_nick, :osu_nick, :summoner_name,
                                    :commands_attributes => [:id, :name, :on, :admin, :limit])
    end

end
