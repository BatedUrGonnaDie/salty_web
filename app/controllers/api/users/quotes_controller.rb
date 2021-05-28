class Api::Users::QuotesController < Api::ApplicationController
  before_action :set_user
  before_action :check_for_quotes, only: [:index]
  before_action :authenticate, only: [:create, :update, :destroy]
  before_action :set_util, only: [:update, :destroy]

  def index
    check_reviewed(@user.quotes)
    render status: 200, json: {
      status: 200,
      quotes: @r_text.sample(limit).map { |quote| {text: quote.text} }
    }
  end

  def create
    @quote = Quote.new(user_id: @user.id, reviewed: params[:reviewed], text: params[:text])
    if @quote.save
      render status: 200, json: {
        status: 200,
        quote: @quote
      }
    else
      render status: 400, json: {
        status: 400,
        error: "Failed to save."
      }
    end
  end

  def update
    if @tutil.update :reviewed, params[:reviewed]
      render status: 200, json: {
        status: 200,
        quote: @tutil
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

    def check_for_quotes
      if @user.quotes.empty?
        render status: 400, json: {status: 400, message: "No quotes for this user."}
      end
    end
end
