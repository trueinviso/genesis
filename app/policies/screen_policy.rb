class ScreenPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.includes(
        [
          :picture,
          :downloaded_by,
          :favorited_by,
          :category,
          :tags,
        ],
      ).order(created_at: :desc).all
    end
  end

  def index?
    user.subscribed? || user.role?(:admin)
  end

  def show?
    user.subscribed? || user.role?(:admin)
  end

  def search?
    user.subscribed? || user.role?(:admin)
  end
end
