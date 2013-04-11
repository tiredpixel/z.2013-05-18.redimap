# Redimap

Redimap provides a simple executable for polling mailboxes
within an IMAP account. It keeps track of what it's seen using Redis. For new
messages, the mailbox and uid are queued in Redis. The format used should be
compatible with Resque.

More sleep lost by [tiredpixel](http://www.tiredpixel.com).


## Installation

Install using:

    $ gem install redimap


## Usage

Ensure that you are setting the required environment variables, perhaps using
Foreman. You'll probably want to at least set:

    IMAP_HOST=imap.gmail.com
    IMAP_USERNAME=username@example.com
    IMAP_PASSWORD=ssssshhhhhhh
    IMAP_MAILBOXES=["INBOX","Sent"]

Check and queue new messages and quit:

    $ bundle exec redimap

Check and queue new messages but run for eternity using crude polling:

    $ bundle exec redimap 1


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
