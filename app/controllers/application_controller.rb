class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate, :authorize

  def current_user
    @current_user
  end
  helper_method :current_user

  def perms
    @perms ||= Authorization.new current_user, params
  end

  def authenticate
    authenticate_with_http_token do |token, options|
      @access_token = AccessToken.where("expires_at > :now", now: Time.now).find_by(token: token)
      @current_user = User.find(@access_token.user_id) if @access_token
    end
  end

  def not_authorized_nil_user
    render text: 'Not Authorized', status: :unauthorized
  end

  def resource
    nil
  end

  def authorize
    if perms.will.allow? resource
      perms.will.permit_params! params
    else
      # TODO
      if current_user
        raise ActionController::RoutingError.new('Not Found')
      else
        not_authorized_nil_user
      end
    end
  end
end
