class FavoriteScreenPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.includes(:user, screen: [:picture, :favorited_by, :downloaded_by]).where(user: user)
    end
  end

  def index?
    true
  end
end
