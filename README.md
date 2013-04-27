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

    $ bundle exec redimap --host mail.example.com --user a@example.com --password helpimacarrot

It is also possible to set config using environment variables. Command-line
options override environment variables. Note that environment variables are in
lowercase, and are named differently to command-line parameters.

    $ imap_host=mail.example.com imap_user=a@example.com imap_password=helpimacarrot bundle exec redimap

The complete list of available environment variables is:

    eternal
    log_level
    imap_host
    imap_port
    imap_username
    imap_password
    imap_mailboxes
    redis_url
    redis_ns_redimap
    redis_ns_queue
    polling_interval

Use `--eternal` or `eternal=1` to run eternally.


## Contributions

Contributions are embraced with much love and affection! Please fork the
repository and wizard your magic, ensuring that any tests are not broken by the
changes. Then send a pull request. Simples! If you'd like to discuss what you're
doing or planning to do, or if you get stuck on something, then just wave. :)

Do whatever makes you happy. We'll probably still like you. :)

## Blessing

May you find peace, and help others to do likewise.


## Licence

© [tiredpixel](http://www.tiredpixel.com) 2013. It is free software, released
under the MIT License, and may be redistributed under the terms specified in
`LICENSE`.
