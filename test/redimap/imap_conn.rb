require 'minitest/autorun'

require_relative '../../lib/redimap'
require_relative '../../lib/redimap/imap_conn'


describe Redimap::ImapConn do
  
  def imap_conn_new
    @net_imap = Minitest::Mock.new
    @net_imap.expect(:login, nil, [nil, nil])
    
    Net::IMAP.stub(:new, @net_imap) do
      @imap_conn = Redimap::ImapConn.new
    end
  end
  
  describe "#initialize" do
    before do
      @config = Redimap::Config.new
      
      @net_imap = Minitest::Mock.new
    end
    
    it "connects with correct imap_username,imap_password" do
      @net_imap.expect(:login, nil, ["schoenberg@example.com", "DerKrankeMond"])
      
      @config.imap_username = "schoenberg@example.com"
      @config.imap_password = "DerKrankeMond"
      
      Net::IMAP.stub(:new, @net_imap) do
        Redimap.stub(:config, @config) do
          @imap_conn = Redimap::ImapConn.new
        end
      end
      
      @net_imap.verify
    end
    
    it "connects with correct imap_host" do
      @net_imap.expect(:login, nil, [nil, nil])
      
      @config.imap_host = 'arnold.example.com'
      
      Net::IMAP.stub(:new, lambda { |imap_host, params|
        imap_host.must_equal('arnold.example.com')
        
        @net_imap
      }) do
        Redimap.stub(:config, @config) do
          @imap_conn = Redimap::ImapConn.new
        end
      end
    end
    
    it "connects with correct imap_port,ssl" do
      @net_imap.expect(:login, nil, [nil, nil])
      
      @config.imap_port = 666
      
      Net::IMAP.stub(:new, lambda { |imap_host, params|
        params.must_equal({ :port => 666, :ssl => true })
        
        @net_imap
      }) do
        Redimap.stub(:config, @config) do
          @imap_conn = Redimap::ImapConn.new
        end
      end
    end
  end
  
  describe "#close" do
    before do
      imap_conn_new
    end
    
    it "disconnects from mailbox" do
      @net_imap.expect(:logout, nil)
      @net_imap.expect(:disconnect, nil)
      
      @imap_conn.close
      
      @net_imap.verify
    end
  end
  
  describe "#read_mailbox" do
    before do
      imap_conn_new
    end
    
    it "gets all INBOX uids when default" do
      @net_imap.expect(:select, nil, ['INBOX'])
      @net_imap.expect(:uid_search, [1, 2, 3], ['1:*'])
      
      @imap_conn.read_mailbox.must_equal [1, 2, 3]
    end
    
    it "gets all Sent uids when mailbox:Sent" do
      @net_imap.expect(:select, nil, ['Sent'])
      @net_imap.expect(:uid_search, [1, 2, 3], ['1:*'])
      
      @imap_conn.read_mailbox('Sent').must_equal [1, 2, 3]
    end
    
    it "gets new Sent uids when mailbox:Sent,last_seen_uid:2" do
      @net_imap.expect(:select, nil, ['Sent'])
      @net_imap.expect(:uid_search, [1, 2, 3], ['3:*'])
      
      @imap_conn.read_mailbox('Sent', 2).must_equal [3]
    end
  end
  
end
