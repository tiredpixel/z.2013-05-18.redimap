module Redimap
  class Config
    
    attr_reader :imap_host
    attr_reader :imap_port
    attr_reader :imap_username
    attr_reader :imap_password
    
    def initialize
      @imap_host     = ENV['IMAP_HOST']
      @imap_port     = ENV['IMAP_PORT']     || 993
      @imap_username = ENV['IMAP_USERNAME']
      @imap_password = ENV['IMAP_PASSWORD']
    end
    
  end
end
