class Authentication

  def initialize(params)
    @params = params
  end

  def user
    @user ||= User.find_by(login_name: @params[:login_name]) if @params[:login_name]
  end

  def authenticated?
    auth_from_password
  end

  def missing_params?
    @params[:login_name].nil? or @params[:password].nil?
  end

private

  def auth_from_password
    user.authenticate(@params[:password]) if user
  end
end
