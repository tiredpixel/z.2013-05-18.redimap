require 'spec_helper'

describe Redimap::Config do
  
  context "Defaults" do
    before(:each) do
      ENV.stub(:[])
      
      @config = Redimap::Config.new
    end
    
    it "imap_port should default to 993" do
      @config.imap_port.should == 993
    end
  end
  
  context "Non-defaults" do
    before(:each) do
      ENV.stub(:[]).with("IMAP_HOST").and_return("imap.carrot.localhost")
      ENV.stub(:[]).with("IMAP_PORT").and_return(666)
      ENV.stub(:[]).with("IMAP_USERNAME").and_return("Pachelbel")
      ENV.stub(:[]).with("IMAP_PASSWORD").and_return("Canon")
      
      @config = Redimap::Config.new
    end
    
    it "imap_host should get set from IMAP_HOST" do
      @config.imap_host.should == "imap.carrot.localhost"
    end
    
    it "imap_port should get set from IMAP_PORT" do
      @config.imap_port.should == 666
    end
    
    it "imap_username should get set from IMAP_USERNAME" do
      @config.imap_username.should == "Pachelbel"
    end
    
    it "imap_password should get set from IMAP_PASSWORD" do
      @config.imap_password.should == "Canon"
    end
  end
  
end
