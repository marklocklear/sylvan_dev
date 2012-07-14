module RadSeoPageTags
  include Radiant::Taggable
  class TagError < StandardError; end
  
  [:link_title, :page_title].each do |method|
    desc %{
      Renders the @#{method}@ attribute of the current page.
    }
    tag method.to_s do |tag|
      tag.locals.page.send(method)
    end
  end
  
  desc %{
    Renders the SEO Page Title if avaliable other wise the standard page title is rendered.
    Html <code><title></title></code> tags are included.
  }
  tag 'seo_title' do |tag|

    if tag.render('page_title').empty?
      @title = tag.render('title') + ' | Sylvan Sport: GO Mobile Adventure Gear'
    else
      @title = tag.render('page_title')
    end
    
    options = tag.attr.dup
    
    if options['html'] == 'false'
      return @title
    else
      return '<title>' + @title + '</title>'
    end
    
  end
  
  
  desc %{
    Renders a link to the page. When used as a single tag it uses the page&apos;s title
    for the link name. When used as a double tag the part in between both tags will
    be used as the link text. The link tag passes all attributes over to the HTML
    @a@ tag. This is very useful for passing attributes like the @class@ attribute
    or @id@ attribute. If the @anchor@ attribute is passed to the tag it will
    append a pound sign (<code>#</code>) followed by the value of the attribute to
    the @href@ attribute of the HTML @a@ tag--effectively making an HTML anchor.
     
    *Usage:*
    <pre><code><r:link [anchor="name"] [other attributes...] /></code></pre>
    or
    <pre><code><r:link [anchor="name"] [other attributes...]>link text here</r:link></code></pre>
  }
  tag 'link' do |tag|
    options = tag.attr.dup
    anchor = options['anchor'] ? "##{options.delete('anchor')}" : ''
    attributes = options.inject('') { |s, (k, v)| s << %{#{k.downcase}="#{v}" } }.strip
    attributes = " #{attributes}" unless attributes.empty?
    text = tag.double? ? tag.expand : tag.render('title')
    title_attribute = " title='#{tag.render('link_title')}'" unless tag.render('link_title').empty?
    %{<a href="#{tag.render('url')}#{anchor}"#{title_attribute}#{attributes}>#{text}</a>}
  end

  
end
