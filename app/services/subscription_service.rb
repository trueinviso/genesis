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

  def find_subscription(stripe_id)
    Stripe::Subscription.retrieve(stripe_id)
  end

  def update_subscription(subscription, params)
    if new_plan_requested?(subscription, params)
      stripe_subscription = find_subscription(subscription.stripe_subscription_id)
      stripe_subscription.plan = params[:user][:subscription_attributes][:stripe_plan_id]
      stripe_subscription.save
      update_local_plan_details(subscription, params)
    end
  end

  def update_card(user, params)
    change_card(user.stripe_id, params)
    update_local_card_details(user, params)
  end

  def cancel_subscription(current_user)
    customer = find_customer(current_user.stripe_id)
    local_subscription = current_user.subscription
    subscription = customer.subscriptions.retrieve(local_subscription.stripe_subscription_id)
    subscription.delete(at_period_end: true)
    mark_as_cancelled(local_subscription, subscription)
  end

  private

  def new_plan_requested?(subscription, params)
    subscription.stripe_plan_id != params[:user][:subscription_attributes][:stripe_plan_id]
  end

  def update_local_plan_details(subscription, params)
    subscription.update!(
      stripe_plan_id: params[:user][:subscription_attributes][:stripe_plan_id]
    )
  end

  def update_local_card_details(user, params)
    if params[:payment_token].present?
      subscription = user.subscription
      subscription.update!(
        card_exp_month: params[:card_exp_month],
        card_exp_year: params[:card_exp_year],
        card_last4: params[:card_last4],
        card_brand: params[:card_brand]
      )
    end
  end

  def change_card(customer_id, params)
    if params[:payment_token].present?
      customer = find_customer(customer_id)
      new_card = customer.sources.create(source: params[:payment_token])
      customer.sources.retrieve(customer.default_source).delete
      customer.default_source = new_card.id
      customer.save
    end
  end

  def mark_as_cancelled(local_sub, stripe_sub)
    local_sub.update!({ ends_at: Time.at(stripe_sub.current_period_end) })
  end
end
