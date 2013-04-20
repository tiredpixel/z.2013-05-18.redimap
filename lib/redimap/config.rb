require 'json'


module Redimap
  class Config
    
    attr_accessor :imap_host
    attr_accessor :imap_port
    attr_accessor :imap_username
    attr_accessor :imap_password
    
    attr_accessor :imap_mailboxes
    
    attr_accessor :redis_url
    attr_accessor :redis_ns_redimap
    attr_accessor :redis_ns_queue
    
    attr_accessor :polling_interval
    
    def initialize
      @logger = Redimap.logger
      
      @imap_host     = ENV['IMAP_HOST']
      @imap_port     = ENV['IMAP_PORT']     || 993
      @imap_username = ENV['IMAP_USERNAME']
      @imap_password = ENV['IMAP_PASSWORD']
      
      @imap_mailboxes = JSON.parse(ENV['IMAP_MAILBOXES'] || '["INBOX"]')
      
      @redis_url        = ENV['REDIS_URL']        || "redis://127.0.0.1:6379/0"
      @redis_ns_redimap = ENV['REDIS_NS_REDIMAP'] || "redimap"
      @redis_ns_queue   = ENV['REDIS_NS_QUEUE']   || "resque"
      
      @polling_interval = (ENV['POLLING_INTERVAL'] || 60).to_i
      
      @logger.debug { "Initialized #{to_s}" }
    end
    
    def to_s
      {
        :imap_host     => @imap_host,
        :imap_port     => @imap_port,
        :imap_username => @imap_username,
        
        :imap_mailboxes => @imap_mailboxes,
        
        :redis_url        => @redis_url,
        :redis_ns_redimap => @redis_ns_redimap,
        :redis_ns_queue   => @redis_ns_queue,
        
        :polling_interval => @polling_interval,
      }
    end
    
  end
end
