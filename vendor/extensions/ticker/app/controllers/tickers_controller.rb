class TickersController < ApplicationController
  
  no_login_required
  
  def index
    @tickers = Ticker.all

    respond_to do |format|
      format.json  { render :json => @tickers.to_json(:only => [:title, :url]) }
    end
  end
end
