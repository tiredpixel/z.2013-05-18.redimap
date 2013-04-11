require 'json'


module Redimap
  class Config
    
    attr_reader :imap_host
    attr_reader :imap_port
    attr_reader :imap_username
    attr_reader :imap_password
    
    attr_reader :imap_mailboxes
    
    attr_reader :redis_url
    attr_reader :redis_ns_redimap
    attr_reader :redis_ns_queue
    
    attr_reader :polling_interval
    
    def initialize
      @imap_host     = ENV['IMAP_HOST']
      @imap_port     = ENV['IMAP_PORT']     || 993
      @imap_username = ENV['IMAP_USERNAME']
      @imap_password = ENV['IMAP_PASSWORD']
      
      @imap_mailboxes = JSON.parse(ENV['IMAP_MAILBOXES'] || '["INBOX"]')
      
      @redis_url        = ENV['REDIS_URL']        || "redis://127.0.0.1:6379/0"
      @redis_ns_redimap = ENV['REDIS_NS_REDIMAP'] || "redimap"
      @redis_ns_queue   = ENV['REDIS_NS_QUEUE']   || "resque"
      
      @polling_interval = ENV['POLLING_INTERVAL'].to_i || 60
    end
    
  end
end
