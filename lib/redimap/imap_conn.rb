require 'net/imap'


module Redimap
  class ImapConn
    
    def initialize
      begin
        @imap = Net::IMAP.new(Redimap.config.imap_host, {
          :port => Redimap.config.imap_port,
          :ssl  => true
        })
        
        @imap.login(Redimap.config.imap_username, Redimap.config.imap_password)
      rescue Net::IMAP::NoResponseError => e
        Redimap.logger.error { e.to_s }
        
        return
      end
      
      if block_given?
        yield self
        
        close
      end
    end
    
    def close
      @imap.logout
      
      @imap.disconnect
    end
    
    def read_mailbox(mailbox = "INBOX", last_seen_uid = 0)
      @imap.select(mailbox)
      
      uids = @imap.uid_search("#{last_seen_uid + 1}:*")
      
      uids.find_all { |uid| uid > last_seen_uid } # IMAP search gets fun with edge cases.
    end
    
  end
end
