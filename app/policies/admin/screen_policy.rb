module Admin
  class ScreenPolicy < ApplicationPolicy
    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope.last.includes(:picture, :category).all
      end
    end

    def index?
      user.role?(:admin)
    end

    def new?
      user.role?(:admin)
    end

    def create?
      user.role?(:admin)
    end

    def show?
      user.role?(:admin)
    end

    def update?
      user.role?(:admin)
    end

    def destroy?
      user.role?(:admin)
    end
  end
end
