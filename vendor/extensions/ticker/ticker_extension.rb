# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class TickerExtension < Radiant::Extension
  version "1.0"
  description "Radiant Ticker Extension"
  url ""
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem
  #   config.after_initialize do
  #     run_something
  #   end
  # end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    tab 'Content' do
      add_item "Ticker", "/admin/tickers", :after => "Pages"
    end
  end
end
