require 'httparty'

# Public: An API wrapper for What.cd's JSON API.
#
# Examples
# 
#   WhatCD::authenticate 'username', 'password'
#   
#   WhatCD::User :id => 666
#   => { ... }
#   
#   WhatCD::Browse :searchstr => 'The Flaming Lips'
#   => { ... }
class WhatCD
  include HTTParty

  base_uri 'https://what.cd'
  maintain_method_across_redirects
  format :json

  class << self
    # Public: Authenticates with the API. Keep in mind that you only have six
    # tries!
    #
    # username - The username String.
    # password - The password String.
    #
    # Returns a HTTParty::CookieHash. Raises an AuthError.
    def authenticate(username, password)
      body     = { username: username, password: password, keeplogged: 1 }
      response = post '/login.php', body: body, 
                 follow_redirects: false

      if response.headers.has_key? 'set-cookie'
        cookie_jar = HTTParty::CookieHash.new
        cookie_jar.add_cookies response.headers['set-cookie']

        cookies cookie_jar
      else
        raise AuthError
      end
    end

    # Public: Checks if there's properly authenticated.
    #
    # Returns a Boolean.
    def authenticated?
      cookies.has_key? :session
    end

    # Public: Makes a request. The "method" name (capitalized!) is one of the
    # API actions (ajax.php?action=<this-bit>).
    #
    # query - A query Hash.
    #
    # Returns a Hash. Raises an AuthError or APIError.
    #
    # Examples
    # 
    #   WhatCD::User :id => 666
    #   # => <Hash ...>
    #
    # Signature
    # 
    #   Action(query)
    def method_missing(method, *args, &block)
      if method.to_s == method.to_s.capitalize
        make_request method.to_s.downcase, args.first
      else
        super
      end
    end

    # Public: Makes a request without a query. See method_missing for usage.
    #
    # Returns a String or Hash. Raises an AuthError or APIError.
    def const_missing(constant)
      # Rippy's response differs from the other respones.
      constant == :Rippy ? rippy : make_request(constant.to_s.downcase)
    end

  private

    # Internal: Makes a request.
    #
    # action - An action name String.
    # query  - A query Hash to send along (default: {}).
    #
    # Returns a Hash representing JSON. Raises an AuthError or APIError.
    def make_request(action, query = {})
      raise AuthError unless authenticated?

      result = get '/ajax.php', query: query.merge(action: action)

      if result.code != 200 || result['status'] == 'failure'
        raise APIError
      else
        result['response']
      end
    end

    # Internal: Gets a Rippy quote.
    #
    # json - A Boolean indicating wether or not the return value should be
    #        JSON (default: false).
    #
    # Returns a String or Hash.
    def rippy(json = false)
      raise AuthError unless authenticated?

      result = get '/ajax.php', query: { action: 'rippy', format: 'json' }
      
      if result.code != 200 || result['status'] == 'failure'
        raise(APIError)
      else
        json ? result : result['rippy']
      end
    end
  end

  # Internal: Gets raised whenever failure occured. Error messages will be
  # vague, as What.cd's API doesn't give any reasons for failure.
  class APIError < Exception; end

  # Internal: Gets raised when a request is made without authenticating first.
  class AuthError < Exception; end
end
