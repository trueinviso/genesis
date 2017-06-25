class SubscriptionService
  def create_customer(user, payload)
    if user.stripe_id?
      find_customer(user.stripe_id)
    else
      Stripe::Customer.create(payload)
    end
  end

  # Use this to update payment token?
  def update_customer(payload)
    Stripe::Customer.update(payload)
  end

  def create_subscription(payload)
    # Need to check if customer has active subscription
    Stripe::Subscription.create(payload)
  end

  def find_customer(stripe_id)
    Stripe::Customer.retrieve(stripe_id)
  end

  def update_subscription(payload)
    Stripe::Subscription.update(payload)
  end

  def cancel_subscription(id)
    Stripe::Subscription.cancel(id)
  end
end
