module Permissions
  class GuestPermission < BasePermission
    def self.rules
      [
        :view__home,
        :login__api_v1_tokens
      ]
    end
  end
end
