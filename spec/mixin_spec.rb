require 'spec_helper'
require 'warnings/mixin'

describe Warnings::Mixin do
  subject { Object.new.extend(Warnings::Mixin) }

  it "should allow adding warnings to $WARNINGS" do
    subject.warn "test1"

    $WARNINGS.last.message.should == "test1"
  end
end
