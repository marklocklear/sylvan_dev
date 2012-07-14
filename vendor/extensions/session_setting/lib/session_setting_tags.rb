module SessionSettingTags
  include Radiant::Taggable
  
  tag "sessionclass" do |tag|
    unless request.session[:session_setting]
      return "bike"
    else
      return request.session[:session_setting]
    end
  end
  
end