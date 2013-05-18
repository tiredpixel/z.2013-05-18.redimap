require 'json'

require 'minitest/autorun'

require_relative '../../lib/redimap'
require_relative '../../lib/redimap/redis_conn'


describe Redimap::RedisConn do
  
  def redis_conn_new
    @redis = Minitest::Mock.new
    @redis.expect(:ping, nil)
    
    Redis.stub(:connect, @redis) do
      @redis_conn = Redimap::RedisConn.new
    end
  end
  
  describe "#initialize" do
    before do
      @config = Redimap::Config.new
      
      @redis = Minitest::Mock.new
      @redis.expect(:ping, nil)
    end
    
    it "connects with correct url" do
      @config.redis_url = 'redis://bminor.example.com:6379/7'
      
      Redis.stub(:connect, lambda { |params|
        params.must_equal({ :url => 'redis://bminor.example.com:6379/7' })
        
        @redis
      }) do
        Redimap.stub(:config, @config) do
          @redis_conn = Redimap::RedisConn.new
        end
      end
    end
    
    it "sets up KEYS semi-constants" do
      @config.redis_ns_redimap = 'reetabix'
      @config.redis_ns_queue   = 'magicmango'
      
      Redimap.stub(:config, @config) do
        redis_conn_new
      end
      
      @redis_conn.instance_variable_get("@KEYS").must_equal({
        :redimap_mailboxes    => 'reetabix:mailboxes',
        :resque_queues        => 'magicmango:queues',
        :resque_queue_redimap => 'magicmango:queue:redimap',
      })
    end
  end
  
  describe "#close" do
    before do
      redis_conn_new
    end
    
    it "disconnects" do
      @redis.expect(:quit, nil)
      
      @redis_conn.close
      
      @redis.verify
    end
  end
  
  describe "#get_mailbox_uid" do
    before do
      redis_conn_new
    end
    
    it "gets uid for mailbox when existing" do
      @redis.expect(:hget, 17, ['redimap:mailboxes', 'Badger'])
      
      @redis_conn.get_mailbox_uid('Badger').must_equal(17)
    end
    
    it "gets uid for mailbox when new" do
      @redis.expect(:hget, nil, ['redimap:mailboxes', 'Badger'])
      
      @redis_conn.get_mailbox_uid('Badger').must_equal(0)
    end
  end
  
  describe "#set_mailbox_uid" do
    before do
      redis_conn_new
    end
    
    it "sets uid for mailbox" do
      @redis.expect(:hset, nil, ['redimap:mailboxes', 'Ferret', 99])
      
      @redis_conn.set_mailbox_uid('Ferret', 99)
      
      @redis.verify
    end
  end
  
  describe "#queue_mailbox_uid" do
    before do
      redis_conn_new
    end
    
    it "adds queue to set of queues and pushes job onto queue" do
      @redis.expect(:sadd, nil, ['resque:queues', 'redimap'])
      @redis.expect(:rpush, nil, ['resque:queue:redimap', {
        'class' => 'RedimapJob',
        'args'  => ['Hedgehog', 49],
        'queue' => 'redimap',
        'retry' => true,
        'jid'   => 'ohsorandom',
      }.to_json])
      
      SecureRandom.stub(:hex, 'ohsorandom') do
        @redis_conn.queue_mailbox_uid('Hedgehog', 49)
      end
      
      @redis.verify
    end
  end
  
end
