module GLPI
  module SDK
    class Session
      include HTTParty

      attr_accessor :token

      def initialize(url, app_token, username, password)
        @url = url
        @app_token = app_token
        @auth = { username: username, password: password }
      end

      # Request a session token to uses other api endpoints
      def init
        options = {
          headers: { 'App-Token' => @app_token },
          basic_auth: @auth
        }

        response = request(:get, '/initSession', options)
        self.token = response['session_token']
      end

      # Destroy a session identified by a session token.
      def kill
        options = {
          headers: { 'App-Token' => @app_token, 'Session-Token' => token }
        }

        request(:get, '/killSession', options)
        self.token = nil
      end

      def request(method, endpoint, options = {})
        options[:base_uri] = @url
        response = self.class.send(method, endpoint, options)

        unless response.success?
          type, message = response.parsed_response
          Error.dispatch(type, message)
        end

        response.parsed_response
      end
    end
  end
end
