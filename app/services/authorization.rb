class Authorization
  def initialize(user, params)
    @user = user
    @params = params
    if @user.nil?
      @perms = Permissions::GuestPermission.new nil, @params
    else
      role_name = @user.role.name
      @perms = "Permissions::#{role_name.camelize}Permission".constantize.new user, @params
    end
  end

  def will
    @perms
  end
end
