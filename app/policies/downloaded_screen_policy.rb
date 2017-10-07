class DownloadedScreenPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.includes(
        :user,
        screen: [
          :picture,
          :favorited_by,
          :downloaded_by,
          :tags,
          :category,
        ],
      ).where(user: user)
    end
  end

  def index?
    user.subscribed? || user.role?(:admin)
  end

  def create?
    user.subscribed? || user.role?(:admin)
  end
end
