module RobotHelper

  def build_full_url(page)
    hostname = Radiant::Config["rad_seo.domain"]
    temp = page
    url = temp.url
    # while !temp.parent.nil?
    #   url = temp.slug + '/' + url
    #   temp = temp.parent
    # end
    return hostname + url
  end

end
