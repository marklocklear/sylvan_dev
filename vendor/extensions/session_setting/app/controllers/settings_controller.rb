class SettingsController < ApplicationController
  
  no_login_required
 
  def reset
  	session[:session_setting] = nil
  	
  	respond_to do |format|
      format.html { render :partial => "settings/reset.json" }
    end
  end
  
  def update
  	session[:session_setting] = params[:setting]
  	
  	respond_to do |format|
      format.html { render :json => {:status => "success"} }
    end
  end
  
  def show
    respond_to do |format|
      format.json { render :partial => "settings/show.json" }
    end
  end
  
end
