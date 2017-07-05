class SubscriptionPolicy < ApplicationPolicy
  def destroy?
    (user.subscribed? && user.subscription.id == record.id) || user.role?(:admin)
  end

  def update?
    (user.subscribed? && user.subscription.id == record.id) || user.role?(:admin)
  end
end
