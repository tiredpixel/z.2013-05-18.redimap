require 'net/imap'

require 'spec_helper'


describe Redimap::ImapConn do
  
  before(:each) do
    @fake_net_imap = double(Net::IMAP)
    
    Net::IMAP.stub(:new).and_return(@fake_net_imap)
    
    @fake_net_imap.stub(:login)
  end
  
  context "#initialize" do
    it "should set imap as Net::IMAP" do
      Redimap::ImapConn.new.imap.should == @fake_net_imap
    end
    
    it "should #close when block" do
      Redimap::ImapConn.new do |imap|
        imap.should_receive(:close)
      end
    end
  end
  
  context "#close" do
    before(:each) do
      @imap = Redimap::ImapConn.new
    end
    
    it "should disconnect from IMAP" do
      @imap.imap.stub(:logout)
      
      @imap.imap.should_receive(:disconnect)
      
      @imap.close
    end
    
    it "should logout from IMAP" do
      @imap.imap.stub(:disconnect)
      
      @imap.imap.should_receive(:logout)
      
      @imap.close
    end
  end
  
end
