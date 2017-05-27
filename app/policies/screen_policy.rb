class ScreenPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  def index?
    false
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end
end
