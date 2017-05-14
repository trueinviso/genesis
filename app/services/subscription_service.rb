class SubscriptionService
  def create_customer(args)
    Stripe::Customer.create({
      source: payment_token,
      email:  email
    })
  end

  # Use this to update payment token?
  def update_customer(args)
  end

  def create_subscription(args)
    Stripe::Subscription.create({
      customer: customer,
      plan: plan
    })
  end

  def update_subscription(args)
  end

  def cancel_subscription(args)
  end
end
