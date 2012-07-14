ActionController::Routing::Routes.draw do |map|
  
  map.connect '/tickers/json', :controller => 'tickers', :action => 'index'
  
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :tickers
  end
end