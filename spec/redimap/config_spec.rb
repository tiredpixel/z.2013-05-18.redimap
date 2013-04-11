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
    
    it "redis_url should default to redis://127.0.0.1:6379/0" do
      @config.redis_url.should == "redis://127.0.0.1:6379/0"
    end
    
    it "redis_ns_redimap should default to redimap" do
      @config.redis_ns_redimap.should == "redimap"
    end
    
    it "redis_ns_queue should default to resque" do
      @config.redis_ns_queue.should == "resque"
    end
  end
  
  context "Non-defaults" do
    before(:each) do
      ENV.stub(:[]).with("IMAP_HOST").and_return("imap.carrot.localhost")
      ENV.stub(:[]).with("IMAP_PORT").and_return(666)
      ENV.stub(:[]).with("IMAP_USERNAME").and_return("Pachelbel")
      ENV.stub(:[]).with("IMAP_PASSWORD").and_return("Canon")
      ENV.stub(:[]).with("REDIS_URL").and_return("redis://127.0.0.1:6379/1")
      ENV.stub(:[]).with("REDIS_NS_REDIMAP").and_return("brekyread")
      ENV.stub(:[]).with("REDIS_NS_QUEUE").and_return("sidekiq")
      
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
    
    it "redis_url should get set from REDIS_URL" do
      @config.redis_url.should == "redis://127.0.0.1:6379/1"
    end
    
    it "redis_ns_redimap should get set from REDIS_NS_REDIMAP" do
      @config.redis_ns_redimap.should == "brekyread"
    end
    
    it "redis_ns_queue should get set from REDIS_NS_QUEUE" do
      @config.redis_ns_queue.should == "sidekiq"
    end
  end
  
end
