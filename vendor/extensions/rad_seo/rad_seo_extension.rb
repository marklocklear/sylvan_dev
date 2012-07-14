# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RadSeoExtension < Radiant::Extension
  version "0.5"
  description "SEO Tweaking Extension"
  url "http://www.gapdesigns.com/projects/radseo"
  
  define_routes do |map|
    map.connect 'sitemap.xml', :controller => 'sitemap', :action => 'show', :format => 'xml'
    map.connect 'robots.txt', :controller => 'robot', :action => 'show', :format => 'text'
  end
  
  def activate
    admin.page.edit.add :extended_metadata, 'seo_fields'
    Page.send :include, RadSeoPageTags
  end
  
  def deactivate
  end
  
end
