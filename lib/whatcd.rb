require "faraday"
require "faraday-cookie_jar"
require "json"

# Public: An API wrapper for What.cd's JSON API.
#
# Examples
# 
#   client = WhatCD::Client.new 'username', 'password'
#   
#   client.fetch :user, :id => 666
#   => { ... }
#   
#   client.fetch :browse, :searchstr => 'The Flaming Lips'
#   => { ... }
class WhatCD
  AuthError = Class.new StandardError
  APIError  = Class.new StandardError

  class Client
    attr_reader :connection

    def initialize(username = nil, password = nil)
      @connection = Faraday.new(:url => "https://what.cd") do |builder|
        builder.request :url_encoded
        builder.use :cookie_jar
        builder.adapter Faraday.default_adapter
      end

      unless username.nil? || password.nil?
        authenticate username, password 
      end
    end

    def authenticate(username, password)
      body = { :username => username, :password => password, :keeplogged => 1 }
      res  = connection.post "/login.php", body

      unless res["set-cookie"] && res["location"] == "index.php"
        raise AuthError
      end

      @authenticated = true
    end

    def set_cookie(cookie)
      connection.headers["Cookie"] = cookie
    end

    def authenticated?
      @authenticated
    end

    # Public: Fetches a resource. For all possible resources and parameters see
    # https://github.com/WhatCD/Gazelle/wiki/JSON-API-Documentation.
    #
    # resource   - A resource name Symbol (ajax.php?action=<this part>).
    # parameters - A Hash.
    #
    # Returns a Hash.
    # Raises AuthError when not authenticated yet.
    # Raises AuthError when redirected to /login.php.
    # Raises APIError when a HTTP error occurs.
    # Raises APIError when the response body is `{"status": "failure"}`.
    def fetch(resource, parameters = {})
      unless authenticated?
        raise AuthError
      end

      res = connection.get "ajax.php", parameters.merge(:action => resource)

      if res.status == "302" && res["location"] == "login.php"
        raise AuthError
      elsif !res.success?
        raise APIError, res.status
      end

      parsed_res = JSON.parse res.body

      if parsed_res["status"] == "failure"
        raise APIError
      end

      parsed_res["response"]
    end
  end
end
