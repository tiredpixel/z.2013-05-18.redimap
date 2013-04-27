require 'json'


module Redimap
  class Config
    
    attr_accessor :log_level
    
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
      @log_level = 'INFO'
      
      @imap_port = 993
      
      @imap_mailboxes = ['INBOX']
      
      @redis_url        = 'redis://127.0.0.1:6379/0'
      @redis_ns_redimap = 'redimap'
      @redis_ns_queue   = 'resque'
      
      @polling_interval = 60
    end
    
    def to_s
      {
        :log_level => @log_level,
        
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
