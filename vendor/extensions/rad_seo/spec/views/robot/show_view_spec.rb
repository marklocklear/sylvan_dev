require File.dirname(__FILE__) + '/../../spec_helper'

describe "/robot/show" do
  before do
    render 'robot/show'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', 'Find me in app/views/robot/show.rhtml')
  end
end
