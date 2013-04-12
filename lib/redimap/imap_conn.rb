require 'net/imap'


module Redimap
  class ImapConn
    
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
    
    def read_mailbox(mailbox = "INBOX", last_seen_uid = 0)
      @imap.select(mailbox)
      
      uids = @imap.uid_search("#{last_seen_uid + 1}:*")
      
      uids.find_all { |uid| uid > last_seen_uid } # IMAP search gets fun with edge cases.
    end
    
  end
end
