module Api
  module V1
    class TokensController < ApiController
      # authenticate
      def create
        auth = Authentication.new params
        if auth.missing_params?
          error! 'both login name and password are required'
          options_set! :status, :bad_request
        else
          if auth.authenticated?
            access_token = AccessToken.create user: auth.user, expires_at: Time.now + AppConfig.access_token_expires_in
            data_set! :access_token, access_token.token
          else
            error! 'invalid login and password'
          end
        end
        render_j
      end
    end
  end
end
