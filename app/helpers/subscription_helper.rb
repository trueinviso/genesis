module SubscriptionHelper
  def active_subscription_class(plan)
    subscription.stripe_plan_id == plan ? "active" : ""
  end

  def expiration_date
    "#{subscription.card_exp_month}/#{subscription.card_exp_year[2..3]}"
  end

  def plan_id
    subscription.stripe_plan_id
  end

  def card_brand
    subscription.card_brand
  end

  def card_last4
    subscription.card_last4
  end

  def subscription
    @subscription ||= current_user.subscription
  end
end
