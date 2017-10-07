class PaymentMethodPolicy < ApplicationPolicy
  def edit?
    subscriber? || admin?
  end

  private

  def subscriber?
    user.subscribed? && user.subscription.id == record.id
  end

  def admin?
    user.role?(:admin)
  end
end
