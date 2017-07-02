class SubscriptionService
  def create_customer(payload)
    Stripe::Customer.create(payload)
  end

  # Use this to update payment token?
  def update_customer(payload)
    Stripe::Customer.update(payload)
  end

  def create_subscription(customer, payload)
    # Need to check if customer has active subscription
    raise "User already has active subscription" if customer.subscriptions.count > 0
    customer.subscriptions.create(payload)
  end

  def find_customer(stripe_id)
    Stripe::Customer.retrieve(stripe_id)
  end

  def update_subscription(payload)
    Stripe::Subscription.update(payload)
  end

  def cancel_subscription(current_user)
    customer = find_customer(current_user.stripe_id)
    customer.subscriptions.retrieve(
      current_user.subscription.stripe_subscription_id
    ).delete# (at_period_end: true)
    mark_as_cancelled(current_user.subscription)
  end

  private

  def mark_as_cancelled(subscription)
    subscription.update!({ ends_at: Time.at(subscription.current_period_end) })
  end
end
