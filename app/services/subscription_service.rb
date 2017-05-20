class SubscriptionService
  def create_customer(args)
    Stripe::Customer.create({
      source: args.payment_token,
      email:  args.email
    })
  end

  # Use this to update payment token?
  def update_customer(args)
  end

  def create_subscription(args)
    Stripe::Subscription.create({
      customer: args.customer_id,
      plan: args.plan
    })
  end

  def update_subscription(args)
  end

  def cancel_subscription(args)
  end
end
