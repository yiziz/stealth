module Rules
  module Api
    module V1
      class TokensRule
        def self.rules
          {
            login: [[:create]]
          }
        end
      end
    end
  end
end
