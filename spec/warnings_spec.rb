require 'spec_helper'
require 'warnings'

describe Warnings do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end

  it "should define a $WARNINGS global variable" do
    $WARNINGS.should_not be_nil
  end

  it "should use an Array for $WARNINGS" do
    $WARNINGS.should be_kind_of(Array)
  end
end
