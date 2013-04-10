This is an XMPP Multi-User Chat logger with web-interface written in Ruby. It is made possible by [Sinatra](http://sinatrarb.com), [Blather](https://github.com/adhearsion/blather), and some other awesome software.

Configutation
-------------
XMPP settings (bot's JID, password and nickname and room's name) are specified in `app.rb`. Database to use is specified in `config/database.yml`.

Sphinx search
-------------
`xmpp-logger` uses [Sphinx](http://sphinxsearch.com) search engine and [Thinking Sphinx](http://pat.github.io/thinking-sphinx) gem to provide message search.

Users management
----------------
At least one user must be created to make possible accessing web-interface.

    $ irb
    > require './app'
    > u = User.new(:login => 'admin')
    > u.password = 'admin'
    > u.save

Usage
-----
The easiest way to get `xmpp-logger` up and running is to use `thin -R config.ru start`.

Todo:
-----
* Change title
* Leverage caching
* Add calendar
* Strip repeating line breaks
* Add license
* Solve the problem with timezone
* Move to LESS or SASS
