__Sinatra::Session__ is a small [extension][ext] for [Sinatra][sin] apps that provides several
convenient settings and methods when working with [cookie][cookie]-based sessions.

Setting Name        | Description
--------------------|-----------------------------------------------------------
`session_fail`      | A URL in your app that the client will be redirected to when `session!` is called and the session is not valid. Defaults to `'/login'`
`session_name`      | The name to use for the session cookie
`session_path`      | The session cookie path
`session_domain`    | The session cookie domain
`session_expire`    | The number of seconds from now the cookie will be valid
`session_secret`    | A secret key that is used to check the integrity of session data

Helper Method                 | Description
------------------------------|-------------------------------------------------
`session_start!`              | Starts the session
`session_end!(destroy=true)`  | Ends the session. If `destroy` is false then session data will be preserved, even though future calls to `session?` will return false
`session?`                    | Returns true if the session is valid
`session!`                    | Redirects the client to the URL specified in the `session_fail` option unless the session is valid

Installation
------------

Via [RubyGems][rg]:

    $ sudo gem install sinatra-session

From a local copy:

    $ git clone git://github.com/mjijackson/sinatra-session.git
    $ cd sinatra-session
    $ rake package && sudo rake install

[ext]: http://www.sinatrarb.com/extensions.html
[sin]: http://www.sinatrarb.com/
[cookie]: http://en.wikipedia.org/wiki/HTTP_cookie
[rg]: http://rubygems.org/
