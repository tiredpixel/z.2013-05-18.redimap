require 'net/imap'


module Redimap
  class IMAP
    
    attr_accessor :imap
    
    def initialize
      @imap = Net::IMAP.new(Redimap.config.imap_host, {
        :port => Redimap.config.imap_port,
        :ssl  => true
      })
      
      if @imap
        @imap.login(Redimap.config.imap_username, Redimap.config.imap_password)
      end
      
      if block_given?
        yield self
        
        close
      end
    end
    
    def close
      if @imap
        @imap.logout
        
        @imap.disconnect
      end
    end
    
  end
end
