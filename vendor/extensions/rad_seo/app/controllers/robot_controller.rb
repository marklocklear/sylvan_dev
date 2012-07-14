class RobotController < ApplicationController
  no_login_required
  def show
    @pages = Page.find(:all, :conditions => {:index_for_search => 'no', :status_id => Status[:published].id})
    render :layout => 'robot', :content_type => 'text/plain'
  end
end
