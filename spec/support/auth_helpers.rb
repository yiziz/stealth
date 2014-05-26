require File.dirname(__FILE__) + '/../../config/initializers/app_config.rb'

module AuthHelpers

  def access_token_header
    AppConfig.access_token_header
  end

  def auth_hash_string(options = {})
    header_array = options.collect{|k,v| "#{k.to_s}=\"#{v}\""}.join(',')

  end

  def header_value(s)
    request.headers[access_token_header] = "Token #{s}"
  end

  def auth_with_user(user, options = {})
    access_token = AccessToken.create user: user, expires_at: Time.now + (options[:expires_in] or AppConfig.access_token_expires_in) if user
    auth_with_token(access_token, options)
  end

  def auth_with_token(access_token, options = {})
    token = access_token.token unless options[:token] or access_token.nil?
    options.delete(:token)
    header_value("#{auth_hash_string(token: token)},#{auth_hash_string(options)}")
  end

  def clear_token
    request.headers[access_token_header] = nil
  end

  def parse_auth_param(user_or_hash)
    if user_or_hash.class.name.downcase == 'hash'
      user = user_or_hash[:user]
      auth_options = user_or_hash[:options] or {}
    else
      user = user_or_hash
      auth_options = {}
    end
    return user, auth_options
  end

  ActionDispatch::Integration::RequestHelpers.instance_methods.reject { |a| a.to_s.last == '!' }.each do |action|
    action = action.to_s
    define_method("#{action}_with_user") do |user_or_hash, path, parameters = nil, headers_or_env = nil|
      user, auth_options = parse_auth_param user_or_hash
      headers_or_env = {} unless headers_or_env  
      headers_or_env[access_token_header] = auth_with_user user, auth_options
      send(action, path, parameters, headers_or_env)
    end
  end
end
