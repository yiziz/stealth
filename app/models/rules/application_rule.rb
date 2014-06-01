module Rules
  module ApplicationRule
    def allow
      true
    end
    def deny
      false
    end
    def norm_user?
      #@user and @user.is_norm?
    end
    def guest_user?
      @user == nil
    end
  end
end
