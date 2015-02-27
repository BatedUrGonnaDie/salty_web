class Api::PunsController < Api::ApplicationController
  before_action :set_user
  before_action :check_for_puns, only: [:index]
  before_action :authenticate, only: [:create, :update, :destroy]

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
        error: "Failed to save."
      }
    end
  end

  def update
    @pun = Pun.find_by(id: params[:id])
    if @pun.update_attribute :reviewed, params[:reviewed]
      render status: 200, json: {
        status: 200,
        text: "Updated successfully"
      }
    else
      render status: 400, json: {
        status: 400,
        error: "Something went wrong"
      }
    end
  end

  def destroy
    @pun = Pun.find_by(id: params[:id])
    if @pun.destroy
      render status: 200, json: {
        status: 200,
        text: "Successfully destroyed"
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
