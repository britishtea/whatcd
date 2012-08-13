require 'httparty'

# Public: An API wrapper for What.cd's JSON API.
class WhatCD
  include HTTParty

  base_uri 'what.cd'
  maintain_method_across_redirects
  format :json

  class << self
    # Public: Authenticates with the API. Keep in mind that you only have six
    # tries!
    #
    # username - The username String.
    # password - The password String.
    #
    # Raises an AuthError.
    def authenticate(username, password)
      body     = { username: username, password: password }
      response = post '/login.php', body: body, 
                 follow_redirects: false

      if response.headers.has_key? 'set-cookie'
        headers 'Cookie' => response.headers['set-cookie']
      else
        raise AuthError
      end
    end

    # Public: Checks if there's properly authenticated.
    #
    # Returns a Boolean.
    def authenticated?
      headers.has_key? 'Cookie'
    end

    # Public: Gets a Rippy quote.
    #
    # Returns a String.
    def rippy
      result = get '/ajax.php', query: { action: 'rippy', format: 'json' }
      result['rippy']
    end

    alias_method :Rippy, :rippy

    # Internal: Makes a request.
    #
    # action - An action name String.
    # query  - A query Hash to send along (default: {}).
    #
    # Returns a Hash representing JSON. Raises an APIError.
    def make_request(action, query = {})
      raise AuthError unless authenticated?

      result = get '/ajax.php', query: query.merge(action: action)

      if result.code != 200 || result['status'] == 'failure'
        raise(APIError)
      else
        result['response']
      end
    end

    # Public: Makes a request. The "method" name (capitalized!) is one of the
    # API actions (ajax.php?action=<this-bit>).
    #
    # query - A query Hash.
    #
    # Examples
    # 
    #   WhatCD::User id => 666
    #   # => <Hash ...>
    #
    # Signature
    # 
    #   Method(query)
    def method_missing(method, *args, &block)
      if method.to_s == method.to_s.capitalize
        make_request method.to_s.downcase, args.first
      else
        super
      end
    end

    # Public: Makes a request. See method_missing for usage. Only defined for
    # actions without parameters (e.g. Rippy).
    def const_missing(constant)
      constant == :Rippy ? rippy : super
    end
  end

  # Internal: Gets raised whenever failure occured. Error messages will be
  # vague, as What.cd's API doesn't give any reasons for failure.
  class APIError < Exception; end

  # Internal: Gets raised when a request is made without authenticating first.
  class AuthError < Exception; end
end
