class CreateSubscription
  attr_reader :user, :params, :subscription_service

  def self.for(user, params)
    new(user: user, params: params).execute
  end

  def initialize(user:, params:, subscription_service: SubscriptionService)
    @user = user
    @params = params
    @subscription_service = subscription_service
  end

  def execute
    create
  end

  private

  def create
    stripe_customer = CreateCustomer.for(user, params)
    stripe_subscription = subscription_service.create_subscription(
      stripe_customer, subscription_payload
    )
    build_subscription(stripe_customer, stripe_subscription)
  end

  def subscription_payload
    {
      source: params[:payment_token],
      plan: params[:plan],
    }
  end

  def build_subscription(stripe_customer, stripe_subscription)
    Subscription.find_or_initialize_by(
      user_id: user.id,
    ).update_attributes!(
      user: user,
      stripe_customer_id: stripe_customer.id,
      stripe_subscription_id: stripe_subscription.id,
      stripe_payment_token: stripe_customer.default_source,
      stripe_plan_id: stripe_subscription.plan.id,
      card_exp_month: params[:card_exp_month],
      card_exp_year: params[:card_exp_year],
      card_last4: params[:card_last4],
      card_brand: params[:card_brand],
    )
  end
end
