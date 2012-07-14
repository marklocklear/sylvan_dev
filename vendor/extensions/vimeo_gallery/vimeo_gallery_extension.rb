class VimeoGalleryExtension < Radiant::Extension
  version "0.1"
  description "Provides tags for listing files in a directory"
  url "http://github.com/nbatson/directorytags"
  
  def activate
    Page.send :include, VimeoGalleryTags
    Radiant::Cache.clear
  end
end