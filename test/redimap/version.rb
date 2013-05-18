require 'minitest/autorun'

require_relative '../../lib/redimap/version'


describe "Redimap::VERSION" do
  
  it "uses major.minor.patch" do
    Redimap::VERSION.must_match /\A\d+\.\d+\.\d+\z/
  end
  
end
