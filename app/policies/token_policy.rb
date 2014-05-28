class TokenPolicy < ApiPolicy
  def create?
    allow 
  end
end
