module VimeoGalleryTags
  include Radiant::Taggable
  
  tag 'vimeo' do |tag|
    
    if tag.attr['username']
      @userinput = tag.attr['username']  
    elsif tag.attr['album']
      @userinput = 'album/' + tag.attr['album']
    end
    
    @width = 480
    @height = 360
    
    if tag.attr['width']
      @width = tag.attr['width']
    end
    
    if tag.attr['height']
      @height = tag.attr['height']
    end
    
    # tag.expand
    # return "vimeo gallery base html"
    vimeo_template 'vimeo_gallery/_player'
    
  end
  
  # tag 'vimeo:player' do |tag|
  #   
  #   @playertype = tag.attr['type']
  #   
  #   @width = 480
  #   @height = 360
  #   
  #   if tag.attr['width']
  #     @width = tag.attr['width']
  #   end
  #   
  #   if tag.attr['height']
  #     @height = tag.attr['height']
  #   end
  #   
  #   # include the base html for the vimeo gallery
  #   vimeo_template 'vimeo_gallery/_player'
  # end
  
  # tag 'vimeo:username' do |tag|
  #   
  #   @username = tag.attr['name']
  #   # @category_title = tag.attr['title']
  #   # @username = tag.locals.username
  #   
  #   unless (tag.attr['name'])
  #     raise StandardError.new("Please provide a vimeo video tag for vimeo:category tag's `tag` attribute")
  #   end
  #   
  #   # unless (tag.attr['title'])
  #   #   raise StandardError.new("Please provide a title string vimeo:category tag's `title` attribute")
  #   # end
  #   
  #   vimeo_template 'vimeo_gallery/_user'
  # end
  # 
  # tag 'vimeo:album' do |tag|
  #   
  #   @album = 'album/' + tag.attr['name']
  #   # @category_title = tag.attr['title']
  #   # @username = tag.locals.username
  #   
  #   unless (tag.attr['name'])
  #     raise StandardError.new("Please provide a vimeo video tag for vimeo:category tag's `tag` attribute")
  #   end
  #   
  #   # unless (tag.attr['title'])
  #   #   raise StandardError.new("Please provide a title string vimeo:category tag's `title` attribute")
  #   # end
  #   
  #   vimeo_template 'vimeo_gallery/_album'
  # end
 
  private

    def vimeo_template(filename)
      require 'erb'
      template = ''
      File.open("#{VimeoGalleryExtension.root}/app/views/" + filename + '.html.erb', 'r') { |f|
        template = f.read
      }
      ERB.new(template).result(binding)
    end 
  
end