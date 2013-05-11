# Redimap

Redimap provides a simple executable for polling mailboxes
within an IMAP account. It keeps track of what it's seen using Redis. For new
messages, the mailbox and uid are queued in Redis. The queue format should be
compatible with [Resque](https://github.com/resque/resque) and
[Sidekiq](https://github.com/mperham/sidekiq).

More sleep lost by [tiredpixel](http://www.tiredpixel.com).


## Installation

Install using:

    $ gem install redimap


## Usage

View the available options:

    $ bundle exec redimap --help

Most settings have defaults, but it is necessary to at least set up IMAP.

Check and queue new messages and quit:

    $ bundle exec redimap --imap-host mail.example.com --imap-username a@example.com --imap-password helpimacarrot

Use `--eternal` to run eternally.


## Contributions

Contributions are embraced with much love and affection! Please fork the
repository and wizard your magic, ensuring that any tests are not broken by the
changes. Then send a pull request. Simples! If you'd like to discuss what you're
doing or planning to do, or if you get stuck on something, then just wave. :)

Do whatever makes you happy. We'll probably still like you. :)

Tests are written using [minitest](https://github.com/seattlerb/minitest), which
is included by default in Ruby 1.9 onwards. To run all tests in a pretty way:

    ruby -rminitest/pride test/redimap.rb

Or, if you're of that turn of mind, use [TURN](https://github.com/TwP/turn)
(`gem install turn`):

    turn test/redimap.rb


## Blessing

May you find peace, and help others to do likewise.


## Licence

© [tiredpixel](http://www.tiredpixel.com) 2013. It is free software, released
under the MIT License, and may be redistributed under the terms specified in
`LICENSE`.
