class Api::QuotesController < Api::ApplicationController
  before_action :set_user
  before_action :check_for_quotes, only: [:index]
  before_action :authenticate, only: [:create, :update, :destroy]

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
    @quote = Quote.find_by(id: params[:id])
    if @quote.update_attribute :reviewed, params[:reviewed]
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
    @quote = Quote.find_by(id: params[:id])
    if @quote.destroy
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

    def check_for_quotes
      if @user.quotes.empty?
        render status: 400, json: {status: 400, error: "No quotes for this user."}
      end
    end
end
