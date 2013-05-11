require 'minitest/autorun'

require_relative '../../lib/redimap/config'


describe Redimap::Config do
  
  describe "default" do
    
    subject { Redimap::Config.new }
    
    it "sets log_level to INFO" do
      subject.log_level.must_equal 'INFO'
    end
    
    it "sets imap_port to 993" do
      subject.imap_port.must_equal 993
    end
    
    it "sets imap_mailboxes to INBOX" do
      subject.imap_mailboxes.must_equal ['INBOX']
    end
    
    it "sets redis_url to redis://127.0.0.1:6379/0" do
      subject.redis_url.must_equal 'redis://127.0.0.1:6379/0'
    end
    
    it "sets redis_ns_redimap to redimap" do
      subject.redis_ns_redimap.must_equal 'redimap'
    end
    
    it "sets redis_ns_queue to resque" do
      subject.redis_ns_queue.must_equal 'resque'
    end
    
    it "sets polling_interval to 60" do
      subject.polling_interval.must_equal 60
    end
    
  end
  
  describe "#to_s" do
    
    subject { Redimap::Config.new.to_s }
    
    it "stringifies hash of config" do
      subject.must_equal '{:log_level=>"INFO", :imap_host=>nil, :imap_port=>993, :imap_username=>nil, :imap_mailboxes=>["INBOX"], :redis_url=>"redis://127.0.0.1:6379/0", :redis_ns_redimap=>"redimap", :redis_ns_queue=>"resque", :polling_interval=>60}'
    end
    
  end
  
end
