class Api::PunsController < Api::ApplicationController
  before_action :set_user
  before_action :check_for_puns, only: [:index]
  before_action :authenticate, only: [:create]

  def index
    check_reviewed(@user.puns)
    render status: 200, json: {
      status: 200,
      puns: @r_text.sample(limit).map { |pun| {text: pun.text} }
    }
  end

  def create
    pun = Pun.new(user_id: params[:user_id], reviewed: params[:reviewed], text: params[:text])
    if pun.save
      render status: 200, json: {
        status: 200,
        quote: pun
      }
    else
      render status: 400, json: {
        status: 400,
        error: "Failed to save."
      }
    end
  end

  private

    def check_for_puns
      if @user.puns.empty?
        render status: 400, json: {status: 400, error: "No puns for this user."}
      end
    end
end
