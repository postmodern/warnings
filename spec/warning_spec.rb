require 'spec_helper'
require 'warnings/warning'

describe Warnings::Warning do
  let(:source_file) { 'foo/bar.rb' }
  let(:source_line) { 42 }
  let(:source_method) { 'baz' }

  subject do
    described_class.new("foo", ["#{source_file}:#{source_line}: in `#{source_method}'"])
  end

  describe "#initialize" do
    it "should parse the source-file" do
      subject.source_file.should be == source_file
    end

    it "should parse the source-line" do
      subject.source_line.should be == source_line
    end

    it "should parse the source-method" do
      subject.source_method.should be == source_method
    end
  end

  it "should provide a source_location method" do
    subject.source_location.should be == [source_file, source_line]
  end

  it "should provide a #to_s method" do
    subject.to_s.should be == subject.message
  end
end
