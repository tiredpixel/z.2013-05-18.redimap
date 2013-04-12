require 'spec_helper'


describe Redimap do
  
  context "Constants" do
    it "VERSION should be like major.minor.patch" do
      Redimap::VERSION.should =~ /\A\d+\.\d+\.\d+\z/
    end
  end
  
end
