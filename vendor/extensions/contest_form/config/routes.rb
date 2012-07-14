ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :contest_entries
  end
  
  # export is more important
  map.connect '/admin/contest/export', :controller => "admin/contest_entries", :action => "export"
  
  map.resources :contest_entries
  
  map.connect '/contest/entry-form/', :controller => "contest_entries", :action => "new"
  # map.connect '/go/contest/entry-form/thanks/', :controller => "contest_entries", :action => "thanks"
  
end