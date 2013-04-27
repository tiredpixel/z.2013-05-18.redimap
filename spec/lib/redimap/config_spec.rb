require 'spec_helper'


describe Redimap::Config do
  
  context "Defaults" do
    it "log_level should default to INFO" do
      Redimap.config.log_level.should == "INFO"
    end
    
    it "imap_port should default to 993" do
      Redimap.config.imap_port.should == 993
    end
    
    it "imap_mailboxes should default to [INBOX]" do
      Redimap.config.imap_mailboxes.should == ['INBOX']
    end
    
    it "redis_url should default to redis://127.0.0.1:6379/0" do
      Redimap.config.redis_url.should == "redis://127.0.0.1:6379/0"
    end
    
    it "redis_ns_redimap should default to redimap" do
      Redimap.config.redis_ns_redimap.should == "redimap"
    end
    
    it "redis_ns_queue should default to resque" do
      Redimap.config.redis_ns_queue.should == "resque"
    end
    
    it "polling_interval should default to 60 seconds" do
      Redimap.config.polling_interval.should == 60
    end
  end
  
  context "Non-defaults" do
    before(:each) do
      Redimap.configure do |c|
        c.log_level = "WARN"
        
        c.imap_host     = "imap.carrot.localhost"
        c.imap_port     = 666
        c.imap_username = "Pachelbel"
        c.imap_password = "Canon"
        
        c.imap_mailboxes = ['INBOX', 'SENT']
        
        c.redis_url        = "redis://127.0.0.1:6379/1"
        c.redis_ns_redimap = "brekyread"
        c.redis_ns_queue   = "sidekiq"
        
        c.polling_interval = 300
      end
    end
    
    it "log_level should get set" do
      Redimap.config.log_level.should == "WARN"
    end
    
    it "imap_host should get set" do
      Redimap.config.imap_host.should == "imap.carrot.localhost"
    end
    
    it "imap_port should get set" do
      Redimap.config.imap_port.should == 666
    end
    
    it "imap_username should get set" do
      Redimap.config.imap_username.should == "Pachelbel"
    end
    
    it "imap_password should get set" do
      Redimap.config.imap_password.should == "Canon"
    end
    
    it "imap_mailboxes should get set" do
      Redimap.config.imap_mailboxes.should == ['INBOX', 'SENT']
    end
    
    it "redis_url should get set" do
      Redimap.config.redis_url.should == "redis://127.0.0.1:6379/1"
    end
    
    it "redis_ns_redimap should get set" do
      Redimap.config.redis_ns_redimap.should == "brekyread"
    end
    
    it "redis_ns_queue should get set" do
      Redimap.config.redis_ns_queue.should == "sidekiq"
    end
    
    it "polling_interval should get set" do
      Redimap.config.polling_interval.should == 300
    end
  end
  
end
