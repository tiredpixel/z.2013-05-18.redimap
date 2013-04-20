# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/redimap/version'

Gem::Specification.new do |spec|
  spec.name          = "redimap"
  spec.version       = Redimap::VERSION
  spec.authors       = ["tiredpixel"]
  spec.email         = ["tp@tiredpixel.com"]
  spec.description   = %q{Redimap provides a simple executable for polling mailboxes
    within an IMAP account. It keeps track of what it's seen using Redis. For new
    messages, the mailbox and uid are queued in Redis. The queue format should be
    compatible with Resque and Sidekiq.}
  spec.summary       = %q{Redimap polls IMAP account mailboxes and queues in Redis.}
  spec.homepage      = "https://github.com/tiredpixel/redimap"
  spec.license       = "MIT"
  
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "redis", "~> 3.0.3"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
