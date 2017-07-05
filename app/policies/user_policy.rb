class UserPolicy < ApplicationPolicy
  def edit?
    user.subscribed? || user.role?(:admin)
  end

  def update?
    user.subscribed? || user.role?(:admin)
  end

  def notifications?
    user.subscribed? || user.role?(:admin)
  end

  def edit_subscription?
    user.subscribed? || user.role?(:admin)
  end

  def edit_payment_method?
    user.subscribed? || user.role?(:admin)
  end
end
