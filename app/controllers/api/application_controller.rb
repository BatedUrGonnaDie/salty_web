class Api::ApplicationController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  private
    def set_user
      unless @user = User.find_by(twitch_name: params[:user_id])
        render status: 404, json: {status: 404, message: "Invalid user."}
      end
    end

    def authenticate
      unless current_user == @user
        render status: 403, message: '403 Unauthorized'
      end
    end

    def limit
      if params[:limit].present?
        [0, params[:limit].to_i, 10].sort[1]
      else
        1
      end
    end

    def check_reviewed(text_array)
      @r_text = []
      text_array.each {|t| @r_text.push(t) if t.reviewed}
    end

    def set_util
      @tutil = Textutil.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: 404, json: {status: 404, message: "Textutil with '#{params[:id]}' not found."}
    end
end
