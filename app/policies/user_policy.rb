class UserPolicy < ApplicationPolicy
  def edit?
    true
  end

  def update?
    true
  end

  def notifications?
    true
  end

  def edit_subscription?
    true
  end

  def edit_payment_method?
    true
  end
end
