require 'redis'
require 'json'


module Redimap
  class RedisConn
    
    @@RESCUE_QUEUE = 'redimap'
    @@RESCUE_CLASS = 'RedimapJob'
    
    attr_accessor :redis
    
    def initialize
      @redis = Redis.connect(:url => Redimap.config.redis_url)
      
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
        @@RESCUE_QUEUE
      )
      
      payload = {
        :class => @@RESCUE_CLASS,
        :args  => [mailbox, uid]
      }.to_json
      
      @redis.rpush(
        @KEYS[:rescue_queue_redimap],
        payload
      )
    end
    
  end
end
