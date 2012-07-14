class SitemapController < ApplicationController
  no_login_required
  def show
    @pages = Page.find(:all, :conditions => {:index_for_search => 'yes', :status_id => Status[:published].id})
    render :layout => 'sitemap', :content_type => 'application/xml'
  end
end
