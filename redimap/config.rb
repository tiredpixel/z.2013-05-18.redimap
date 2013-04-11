module Redimap
  class Config
    
    attr_reader :imap_host
    attr_reader :imap_port
    attr_reader :imap_username
    attr_reader :imap_password
    attr_reader :redis_url
    attr_reader :redis_ns_redimap
    attr_reader :redis_ns_queue
    
    def initialize
      @imap_host     = ENV['IMAP_HOST']
      @imap_port     = ENV['IMAP_PORT']     || 993
      @imap_username = ENV['IMAP_USERNAME']
      @imap_password = ENV['IMAP_PASSWORD']
      
      @redis_url        = ENV['REDIS_URL']        || "redis://127.0.0.1:6379/0"
      @redis_ns_redimap = ENV['REDIS_NS_REDIMAP'] || "redimap"
      @redis_ns_queue   = ENV['REDIS_NS_QUEUE']   || "resque"
    end
    
  end
end
