require File.dirname(__FILE__) + '/../spec_helper'

describe ContestEntry do
  before(:each) do
    @contest_entry = ContestEntry.new
  end

  it "should be valid" do
    @contest_entry.should be_valid
  end
end
