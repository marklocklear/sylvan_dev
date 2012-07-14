ActionController::Routing::Routes.draw do |map|
  # map.namespace :admin, :member => { :remove => :get } do |admin|
  #   admin.resources :session_setting
  # end
  map.connect '/session-setting/reset.js', :controller => 'settings', :action => 'reset'
  map.connect '/session-setting/update/:setting', :controller => 'settings', :action => 'update'
  map.connect '/session-setting/show.js', :controller => 'settings', :action => 'show'
end