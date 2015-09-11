class Api::Users::PunsController < Api::ApplicationController
  before_action :set_user
  before_action :check_for_puns, only: [:index]
  before_action :authenticate, only: [:create, :update, :destroy]
  before_action :set_util, only: [:update, :destroy]

  def index
    check_reviewed(@user.puns)
    render status: 200, json: {
      status: 200,
      puns: @r_text.sample(limit).map { |pun| {text: pun.text} }
    }
  end

  def create
    @pun = Pun.new(user_id: @user.id, reviewed: params[:reviewed], text: params[:text])
    if @pun.save
      render status: 200, json: {
        status: 200,
        pun: @pun
      }
    else
      render status: 400, json: {
        status: 400,
        message: "Failed to save."
      }
    end
  end

  def update
    if @tutil.update_attribute(:reviewed, params[:reviewed])
      render status: 200, json: {
        status: 200,
        pun: @tutil
      }
    else
      render status: 400, json: {
        status: 400,
        error: "Something went wrong"
      }
    end
  end

  def destroy
    if @tutil.destroy
      render status: 200, json: {
        status: 200,
        message: "Successfully destroyed"
      }
    else
      render status: 400, json: {
        status: 400,
        error: "Something went wrong"
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
