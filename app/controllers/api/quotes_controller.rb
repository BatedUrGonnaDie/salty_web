class Api::QuotesController < Api::ApplicationController
  before_action :set_user
  before_action :check_for_quotes

  def index
    render status: 200, json: {
      status: 200,
      quotes: @user.quotes.sample(limit).map { |quote| {text: quote.text} }
    }
  end

  private

    def set_user
      unless @user = User.find_by(twitch_name: params[:user_id])
        render status: 400, json: {status: 400, error: "Invalid user."}
      end
    end

    def check_for_quotes
      if @user.quotes.empty?
        render status: 400, json: {status: 400, error: "No quotes for this user."}
      end
    end

    def limit
      if params[:limit].present?
        params[:limit].to_i < 0 ? 0 : params[:limit].to_i
      else
        1
      end
    end
end
