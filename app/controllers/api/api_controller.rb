class Api::ApiController < ActionController::Base

  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

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

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end
end
