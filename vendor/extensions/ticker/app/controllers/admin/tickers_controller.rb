class Admin::TickersController < ApplicationController
  
  def index
    @tickers = Ticker.all
  end

  def show
    # @ticker = Ticker.find(params[:id])
  end

  def new
    @ticker = Ticker.new
  end

  def edit
    @ticker = Ticker.find(params[:id])
  end

  def create
    @ticker = Ticker.new(params[:ticker])

    if @ticker.save
      redirect_to(edit_admin_ticker_url(@ticker), :notice => 'Ticker was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @ticker = Ticker.find(params[:id])

    if @ticker.update_attributes(params[:ticker])
      redirect_to(edit_admin_ticker_url(@ticker), :notice => 'Ticker was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @ticker = Ticker.find(params[:id])
    @ticker.destroy

    redirect_to(admin_tickers_url)
  end
end
