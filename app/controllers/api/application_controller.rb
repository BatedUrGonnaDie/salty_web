class Api::ApplicationController < ApplicationController
  
  respond_to :json

  private
    def set_user
      unless @user = User.find_by(twitch_name: params[:user_id])
        render status: 400, json: {status: 400, error: "Invalid user."}
      end
    end

    def limit
      if params[:limit].present?
        [0, params[:limit].to_i, 10].sort[1]
      else
        1
      end
    end
end
