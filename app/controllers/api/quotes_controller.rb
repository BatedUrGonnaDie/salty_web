class Api::QuotesController < Api::ApplicationController

  def text_show
    user = User.find_by(twitch_name: params[:user])
    if user
      u_quotes = user.quotes
      r_quote_array = []
      num_used = []
      limit = params[:limit] || 1
      limit.times {num_used.push(rand(u_quotes.length))}
      num_used.each do |x| 
        r_quote_array.push(x)
      end
      render status: 200, json: {status: 200, text: r_quote_array}
    else
      render status: 400, json: {status: 400, error: "Invalid user."}
    end
  end


end
