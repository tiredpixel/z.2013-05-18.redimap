module Redimap
  
  VERSION = "0.0.1"
  
  def self.config
    @config ||= Redimap::Config.new
  end
  
  def self.configure
    yield config if block_given?
  end
  
end
