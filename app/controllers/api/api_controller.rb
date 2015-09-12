class Api::ApiController < ActionController::Base

  protected

  def authenticate
    authenticate_or_request_with_http_token do | token, options |
      api_key, digest = token.split(':')
      user = User.find_by_api_key(api_key)
      if user
        user.authenticate_digest(digest, request.headers[:date])
        @current_user = user
      else
        false
      end
    end
  end
end
