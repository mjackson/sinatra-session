Usage
-----

As with all Sinatra [extensions][ext], Sinatra::Session may be used in both classic
and modular-style apps. First, classic.

    require 'sinatra'
    require 'sintra/session'

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

Modular apps use very similar code but must also mixin Sinatra::Session via
Sinatra#register, like so:

    require 'sinatra/base'
    require 'sinatra/session'

    class MyApp < Sinatra::Base
      register Sinatra::Session

      # insert settings and routes here, same as in
      # classic example above
    end

[ext]: http://www.sinatrarb.com/extensions.html
