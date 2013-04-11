require 'redis'
require 'json'


module Redimap
  class RedisConn
    
    QUEUE_QUEUE = 'redimap'
    QUEUE_CLASS = 'RedimapJob'
    
    attr_accessor :redis
    
    def initialize
      @redis = Redis.connect(:url => Redimap.config.redis_url)
      
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
        "#{Redimap.config.redis_ns_queue}:mailboxes",
        mailbox
      ).to_i # Also handles nil.
    end
    
    def set_mailbox_uid(mailbox, uid)
      @redis.hset(
        "#{Redimap.config.redis_ns_queue}:mailboxes",
        mailbox,
        uid
      )
    end
    
    def queue_mailbox_uid(mailbox, uid)
      @redis.sadd(
        "#{Redimap.config.redis_ns_queue}:queues",
        QUEUE_QUEUE
      )
      
      payload = {
        :class => QUEUE_CLASS,
        :args  => [mailbox, uid]
      }.to_json
      
      @redis.rpush(
        "#{Redimap.config.redis_ns_queue}:queue:#{QUEUE_QUEUE}",
        payload
      )
    end
    
  end
end
