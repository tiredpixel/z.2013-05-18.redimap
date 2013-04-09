require 'net/imap'

require 'spec_helper'

describe Redimap::IMAP do
  
  context "#initialize" do
    context "when valid credentials" do
      before(:each) do
        @fake_net_imap = double(Net::IMAP)
        
        Net::IMAP.stub(:new).and_return(@fake_net_imap)
        
        @fake_net_imap.stub(:login)
      end
      
      it "should set imap as Net::IMAP" do
        Redimap::IMAP.new.imap.should == @fake_net_imap
      end
      
      it "should #close when block" do
        Redimap::IMAP.new do |imap|
          imap.should_receive(:close)
        end
      end
    end
    
    context "when invalid credentials" do
      it "should do something or other"
    end
  end
  
  context "#close" do
    context "when extant connection" do
      before(:each) do
        @fake_net_imap = double(Net::IMAP)
        
        Net::IMAP.stub(:new).and_return(@fake_net_imap)
        
        @fake_net_imap.stub(:login)
        
        @imap = Redimap::IMAP.new
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
    
    context "when inextant connection" do
      it "should not try to disconnect from IMAP"
      
      it "should not try to logout from IMAP"
    end
  end
  
end
