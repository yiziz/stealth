class HomePolicy < ApplicationPolicy
  def index?
    allow
  end
end
