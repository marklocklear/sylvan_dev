require File.dirname(__FILE__) + '/../spec_helper'

describe RobotController do

  #Delete these examples and add some real ones
  it "should use RobotController" do
    controller.should be_an_instance_of(RobotController)
  end


  it "GET 'show' should be successful" do
    get 'show'
    response.should be_success
  end
end
