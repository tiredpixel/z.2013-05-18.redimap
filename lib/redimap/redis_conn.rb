require 'redis'
require 'json'


module Redimap
  class RedisConn
    
    QUEUE_QUEUE = 'redimap'
    QUEUE_CLASS = 'RedimapJob'
    
    attr_accessor :redis
    
    def initialize
      @redis = Redis.connect(:url => Redimap.config.redis_url)
      
      @KEYS = {
        :redimap_mailboxes    => "#{Redimap.config.redis_ns_redimap}:mailboxes",
        :rescue_queues        => "#{Redimap.config.redis_ns_queue}:queues",
        :rescue_queue_redimap => "#{Redimap.config.redis_ns_queue}:queue:#{QUEUE_QUEUE}",
      }.freeze
      
      if block_given?
        yield self
        
        close
      end
    end
    
    def close
      if @redis
        @redis.quit
      end
    end
    
    def get_mailbox_uid(mailbox)
      @redis.hget(
        @KEYS[:redimap_mailboxes],
        mailbox
      ).to_i # Also handles nil.
    end
    
    def set_mailbox_uid(mailbox, uid)
      @redis.hset(
        @KEYS[:redimap_mailboxes],
        mailbox,
        uid
      )
    end
    
    def queue_mailbox_uid(mailbox, uid)
      @redis.sadd(
        @KEYS[:rescue_queues],
        QUEUE_QUEUE
      )
      
      payload = {
        :class => QUEUE_CLASS,
        :args  => [mailbox, uid]
      }.to_json
      
      @redis.rpush(
        @KEYS[:rescue_queue_redimap],
        payload
      )
    end
    
  end
end
