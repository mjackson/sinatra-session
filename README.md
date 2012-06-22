**Sinatra::Session** is a small extension for [Sinatra](http://www.sinatrarb.com/)
apps that provides several convenient settings and methods when working with
HTTP cookie-based sessions.

## Settings

    `session_fail`   -> A URL in your app that the client will be redirected to
                        when `session!` is called and the session is not valid.
                        Defaults to '/login'
    `session_name`   -> The name to use for the session cookie
    `session_path`   -> The session cookie path
    `session_domain` -> The session cookie domain
    `session_expire` -> The number of seconds from now the cookie will be valid
    `session_secret` -> A secret key that is used to check the integrity of
                        session data

## Helper Methods

    `session_start!`             -> Starts the session
    `session_end!(destroy=true)` -> Ends the session. If `destroy` is false then
                                    session data will be preserved, even though
                                    future calls to `session?` will return false
    `session?`                   -> Returns true if the session is valid
    `session!`                   -> Redirects the client to the URL specified in
                                    the `session_fail` option unless the session
                                    is valid

## Installation

Via [RubyGems](http://rubygems.org):

    $ sudo gem install sinatra-session

From a local copy:

    $ git clone git://github.com/mjijackson/sinatra-session.git
    $ cd sinatra-session
    $ rake package && sudo rake install

## Usage

As with all Sinatra extensions, `Sinatra::Session` may be used in both classic
and modular-style apps. First, classic.

```ruby
require 'sinatra'
require 'sinatra/session'

set :session_fail, '/login'
set :session_secret, 'So0perSeKr3t!'

get '/' do
  session!
  'Hello, ' + session[:name] + '! Click <a href="/logout">here</a> to logout.'
end

get '/login' do
  if session?
    redirect '/'
  else
    '<form method="POST" action="/login">' +
    'Please enter your name: <input type="text" name="name">' +
    '<input type="submit" value="Submit">' +
    '</form>'
  end
end

post '/login' do
  if params[:name]
    session_start!
    session[:name] = params[:name]
    redirect '/'
  else
    redirect '/login'
  end
end

get '/logout' do
  session_end!
  redirect '/'
end
```

Modular apps use very similar code but must also mixin `Sinatra::Session` via
`Sinatra#register`, like so:

```ruby
require 'sinatra/base'
require 'sinatra/session'

class MyApp < Sinatra::Base
  register Sinatra::Session

  # insert settings and routes here, same as in
  # classic example above
end
```

## License

Copyright 2012 Michael Jackson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

The software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and non-infringement. In no event shall the
authors or copyright holders be liable for any claim, damages or other
liability, whether in an action of contract, tort or otherwise, arising from,
out of or in connection with the software or the use or other dealings in
the software.
