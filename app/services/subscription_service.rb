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
    local_subscription = current_user.subscription
    subscription = customer.subscriptions.retrieve(local_subscription.stripe_subscription_id)
    subscription.delete(at_period_end: true)
    mark_as_cancelled(local_subscription, subscription)
  end

  private

  def mark_as_cancelled(local_sub, stripe_sub)
    local_sub.update!({ ends_at: Time.at(stripe_sub.current_period_end) })
  end
end
