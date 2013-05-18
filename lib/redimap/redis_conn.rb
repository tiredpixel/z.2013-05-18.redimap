require 'redis'
require 'json'
require 'securerandom'


module Redimap
  class RedisConn
    
    @@RESCUE_QUEUE = 'redimap'
    @@RESCUE_CLASS = 'RedimapJob'
    
    def initialize
      begin
        @redis = Redis.connect(:url => Redimap.config.redis_url)
        
        @redis.ping
      rescue Redis::CannotConnectError => e
        Redimap.logger.error { e.to_s }
        
        return
      end
      
      @KEYS = {
        :redimap_mailboxes    => "#{Redimap.config.redis_ns_redimap}:mailboxes",
        :rescue_queues        => "#{Redimap.config.redis_ns_queue}:queues",
        :rescue_queue_redimap => "#{Redimap.config.redis_ns_queue}:queue:#{@@RESCUE_QUEUE}",
      }.freeze
      
      if block_given?
        yield self
        
        close
      end
    end
    
    def close
      @redis.quit
    end
    
    def get_mailbox_uid(mailbox)
      @redis.hget(@KEYS[:redimap_mailboxes], mailbox).to_i # Also handles nil.
    end
    
    def set_mailbox_uid(mailbox, uid)
      @redis.hset(@KEYS[:redimap_mailboxes], mailbox, uid)
    end
    
    def queue_mailbox_uid(mailbox, uid)
      @redis.sadd(@KEYS[:rescue_queues], @@RESCUE_QUEUE)
      
      @redis.rpush(@KEYS[:rescue_queue_redimap], payload(mailbox, uid))
    end
    
    private
    
    def payload(mailbox, uid)
      {
        # resque
        :class => @@RESCUE_CLASS,
        :args  => [mailbox, uid],
        # sidekiq (extra)
        :queue => @@RESCUE_QUEUE,
        :retry => true,
        :jid   => SecureRandom.hex(12),
      }.to_json
    end
    
  end
end
