class SubscriptionPolicy < ApplicationPolicy
  def destroy?
    true
  end

  def update?
    true
  end
end
