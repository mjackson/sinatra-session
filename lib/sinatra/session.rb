require 'sinatra/base'
require 'encrypted_cookie'

module Sinatra
  module Session

    # Request-level helper methods for Sinatra routes.
    module Helpers
      # After this method is called, calls to #session? will return +true+.
      def session_start!
        session['sinatra.session'] = true
      end

      # After this method is called, calls to #session? will return +false+. If
      # you want to keep the old session data around in the cookie for some
      # reason, set +destroy+ to +false+.
      def session_end!(destroy=true)
        if destroy
          session.clear
        else
          session['sinatra.session'] = false
        end
      end

      # Returns +true+ if the current session is valid, +false+ otherwise.
      def session?
        !! session['sinatra.session']
      end

      # Redirects the client to the URL given in the +session_fail+ setting
      # if #session? returns +false+.
      def session!
        redirect(settings.session_fail) unless session? || settings.session_fail == request.path_info
      end
    end

    # A wrapper for the Rack::Session::Cookie middleware that allows an options
    # hash to be returned from the block given to the +use+ statement instead
    # of being provided up front.
    module Cookie
      def self.new(app, options={})
        # If true, use EncryptedCookie. The :session_secret also needs to be a
        # (random) string > 32 chars.
        if (app.settings.session_encrypted && app.settings.session_secret.length >= 32)
          Rack::Session::EncryptedCookie.new(app, {
            :key => app.settings.session_name,
            :path => app.settings.session_path,
            :domain => app.settings.session_domain,
            :expire_after => app.settings.session_expire,
            :secret => app.settings.session_secret
          })
        else
          options.merge!(yield) if block_given?
          Rack::Session::Cookie.new(app, options)
        end
      end
    end

    def self.registered(app)
      app.helpers Session::Helpers

      # This should be set to the redirect URL the client will be sent to if
      # the session is not valid.
      app.set :session_fail, '/login'

      # Set to true to use EncryptedCookie.
      app.set :session_encrypted, false

      # Parameters for the session cookie.
      app.set :session_name, 'sinatra.session'
      app.set :session_path, '/'
      app.set :session_domain, nil
      app.set :session_expire, nil
      app.set :session_secret, nil

      app.use(Session::Cookie) do
        { :key          => app.session_name,
          :path         => app.session_path,
          :domain       => app.session_domain,
          :expire_after => app.session_expire,
          :secret       => app.session_secret
        }
      end
    end
  end

  register Session
end
