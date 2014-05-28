class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate, :define_params, :pundit_authorize
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized!

  include Pundit

  def current_user
    @current_user
  end

  def authenticate
    authenticate_with_http_token do |token, options|
      @access_token = AccessToken.where("expires_at > :now", now: Time.now).find_by(token: token)
      @current_user = User.find(@access_token.user_id) if @access_token
    end
  end

  def not_authorized_nil_user!
    not_authorized!
  end

  def not_authorized!
    render text: I18n.t('authorization.not_authorized'), status: :unauthorized
  end

  def current_resource
    nil
  end

  def target_resource
    return unless current_resource
    current_resource[target_name.to_sym]
  end

  def pundit_authorize
    authorize current_resource
  end

  # overrides pundit's policy def
  def policy(record)
    "#{target_name.classify}Policy".constantize.new current_user, record
  end

  def define_params
    self.class.send(:define_method, "#{target_name}_params") do
      klass = target_name.classify
      params.require(target_name.to_sym).permit(*policy(target_resource || klass.constantize).permitted_attributes)
    end
  end

private

  def target_name
    controller_name.singularize
  end
end
