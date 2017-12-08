module GLPI
  module SDK
    class Session
      include HTTParty

      attr_accessor :token, :app_token

      def initialize(url, app_token, username, password)
        @url = url
        @app_token = app_token
        @auth = { username: username, password: password }

        init
      end

      # Request a session token to uses other api endpoints
      def init
        response = request :get, '/initSession', basic_auth: @auth
        self.token = response['session_token']
      end

      # Destroy a session identified by a session token.
      def kill
        request :get, '/killSession'
        self.token = nil
      end

      # Return the current active profile
      def active_profile
        request :get, '/getActiveProfile'
      end

      # Return active entities of current logged user
      def active_entities
        request :get, '/getActiveEntities'
      end

      # Return the current php $_SESSION
      def full_session
        request :get, '/getFullSession'
      end

      # Return the current $CFG_GLPI
      def glpi_config
        request :get, '/getGlpiConfig'
      end

      def request(method, endpoint, options = {})
        options[:base_uri] = @url

        options[:headers] = options.fetch(:headers, {})
        options[:headers]['Content-Type'] = 'application/json'
        options[:headers]['App-Token'] = @app_token
        options[:headers]['Session-Token'] = @token if @token

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
