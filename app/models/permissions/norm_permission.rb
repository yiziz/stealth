module Permissions
  class NormPermission < BasePermission
    def self.rules
      [
        :view__home, 
      ]
    end
  end
end
