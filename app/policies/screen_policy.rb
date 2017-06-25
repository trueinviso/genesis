class ScreenPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.includes([:picture, :downloaded_by, :favorited_by, :category, :tags]).all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def search?
    true
  end
end
