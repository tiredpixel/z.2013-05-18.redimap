require 'logger'


module Redimap
  
  def self.config
    @config ||= Redimap::Config.new
  end
  
  def self.configure
    yield self.config
  end
  
  def self.logger
    unless @logger
      @logger = Logger.new($stdout)
      
      @logger.level    = Logger.const_get(ENV['LOG_LEVEL'] || 'INFO')
      @logger.progname = :Redimap
    end
    
    @logger
  end
  
  def self.queue_new_mailboxes_uids
    @logger = Redimap.logger
    
    @logger.info { "Queueing new mailboxes UIDs" }
    
    Redimap::ImapConn.new do |imap|
      Redimap::RedisConn.new do |redis|
        begin
          Redimap.config.imap_mailboxes.each do |mailbox|
            last_seen_uid = redis.get_mailbox_uid(mailbox)
            
            @logger.debug { "Last saw #{mailbox}##{last_seen_uid}" }
            
            unseen_uids = imap.read_mailbox(mailbox, last_seen_uid)
            
            unseen_uids.each do |uid|
              redis.queue_mailbox_uid(mailbox, uid)
              
              redis.set_mailbox_uid(mailbox, uid)
            end
            
            @logger.info { "Queued #{unseen_uids.count} UIDs from #{mailbox}" }
          end
        rescue Net::IMAP::Error, Redis::BaseError => e
          @logger.error { e.to_s }
          
          return
        end
      end
    end
  end
  
end
