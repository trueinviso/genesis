class CancelSubscription
  def call(event)
    cancel_local_subscription(event.data.object)
  end

  private

  def cancel_local_subscription(subscription)
    subscription = Subscription.find_by(stripe_subscription_id: subscription.id)
    subscription.update!({ stripe_subscription_id: nil })
  end
end
