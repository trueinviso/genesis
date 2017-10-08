class CreateCustomer
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
    stripe_customer = find_or_create
    user.update!({ stripe_id: stripe_customer.id })
    stripe_customer
  end

  def find_or_create
    if user.stripe_id.present?
      subscription_service.find_customer(user.stripe_id)
    else
      subscription_service.create_customer(customer_payload)
    end
  end

  def customer_payload
    { email: user.email }
  end
end
