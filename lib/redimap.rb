require 'logger'

require_relative 'redimap/version'
require_relative 'redimap/config'

require_relative 'redimap/imap_conn'
require_relative 'redimap/redis_conn'


module Redimap
  
  extend self
  
  def config
    @config ||= Redimap::Config.new
  end
  
  def configure
    yield config
    
    Redimap.logger.debug { "Configured #{Redimap.config.to_s}" }
  end
  
  def logger
    unless @logger
      @logger = Logger.new($stdout)
      
      @logger.level    = Logger.const_get(Redimap.config.log_level)
      @logger.progname = :Redimap
    end
    
    @logger
  end
  
  def queue_new_mailboxes_uids
    Redimap.logger.info { "Queueing new mailboxes UIDs" }
    
    Redimap::ImapConn.new do |imap|
      Redimap::RedisConn.new do |redis|
        begin
          Redimap.config.imap_mailboxes.each do |mailbox|
            last_seen_uid = redis.get_mailbox_uid(mailbox)
            
            Redimap.logger.debug { "Last saw #{mailbox}##{last_seen_uid}" }
            
            unseen_uids = imap.read_mailbox(mailbox, last_seen_uid)
            
            unseen_uids.each do |uid|
              redis.queue_mailbox_uid(mailbox, uid)
              
              redis.set_mailbox_uid(mailbox, uid)
            end
            
            Redimap.logger.info { "Queued #{unseen_uids.count} UIDs from #{mailbox}" }
          end
        rescue Net::IMAP::Error, Redis::BaseError => e
          Redimap.logger.error { e.to_s }
          
          return
        end
      end
    end
  end
  
end
