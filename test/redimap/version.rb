require 'minitest/autorun'

require_relative '../../lib/redimap/version'


describe "Redimap::VERSION" do
  
  subject { Redimap::VERSION }
  
  it "uses major.minor.patch" do
    subject.must_match /\A\d+\.\d+\.\d+\z/
  end
  
end
