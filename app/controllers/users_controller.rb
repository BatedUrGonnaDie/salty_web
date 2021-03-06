class UsersController < ApplicationController
  before_action :set_user, only: [:update, :q_update, :cc_update]
  before_action :authenticate, only: [:update, :q_update, :cc_update]

  def salty
  end

  def update
    if @user.update(user_params.reject{|k, v| k.to_s == "bot_oauth" && v.blank?})
      if send_update
        flash[:success] = "Settings Saved"
      else
        flash[:warning] = "Settings could not be updated in the bot."
      end
    else
      flash[:danger] = "There was an error saving your settings.\n" + @user.errors.full_messages.join('\n')
    end

    redirect_to salty_path
  end

  def quotes
  end

  def q_update
    if @user.update(user_params)
      flash[:success] = "Quotes/Puns Updated"
    else
      flash[:danger] = "There was a problem updating the quotes and puns."
    end
    redirect_to salty_quotes_path
  end

  def custom_commands
  end

  def cc_update
    if @user.update(user_params)
      if send_update
        flash[:success] = "Custom Commands Updated"
      else
        flash[:warning] = "Custom commands could not be updated in the bot."
      end
    else
      flash[:danger] = "There was a problem updating your custom commands."
    end
    redirect_to custom_commands_path
  end

  def guide
  end

  private

  def user_params
    params.require(:user).permit({:settings_attributes => [:id, :active, :youtube_link, :osu_link,
                                  :social_active, :social_output, :social_time, :social_messages,
                                  :toobou_active, :toobou_limit, :toobou_trigger, :toobou_output,
                                  :voting_active, :voting_mods, :sub_message_active, :sub_message_text, :sub_message_resub]},
                                  :twitch_name, :bot_nick, :bot_oauth, :srl_nick, :osu_nick, :summoner_name, :speedruncom_nick,
                                  :commands_attributes => [:id, :name, :on, :admin, :limit],
                                  :custom_commands_attributes => [:id, :trigger, :on, :admin, :limit, :output],
                                  :quotes_attributes => [:id, :text, :reviewed],
                                  :puns_attributes => [:id, :text, :reviewed])
  end

  def set_user
    unless (@user = User.find_by(twitch_name: params[:user][:twitch_name]))
      raise ActiveRecord::RecordNotFound.new('Not Found')
    end
  end

  def authenticate
    render status: 403, text: '403 Unauthorized' unless current_user == @user
  end
end
