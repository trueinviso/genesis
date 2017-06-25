class SubscriptionsController < ApplicationController

  skip_after_action :verify_authorized, only: [:new, :create, :edit]

  def new
    @subscription = Subscription.new
  end

  def create
    stripe_customer = find_or_create_customer
    current_user.update!({ stripe_id: stripe_customer.id })
    stripe_subscription = subscription_service.create_subscription(subscription_payload(stripe_customer))

    @subscription = build_subscription(stripe_customer, stripe_subscription)

    if @subscription.save
      redirect_to root_url
    else
      @subscription.destroy
      render 'new'
    end
  end

  private

    def find_or_create_customer
      if current_user.stripe_id.present?
        subscription_service.find_customer(current_user.stripe_id)
      else
        subscription_service.create_customer(customer_payload)
      end
    end

    def build_subscription(stripe_customer, stripe_subscription)
      Subscription.new({
          user: current_user,
          stripe_customer_id: stripe_customer.id,
          stripe_subscription_id: stripe_subscription.id,
          stripe_payment_token: stripe_customer.default_source,
          stripe_plan_id: stripe_subscription.plan.id,
          card_exp_month: subscription_params[:card_exp_month],
          card_exp_year: subscription_params[:card_exp_year],
          card_last4: subscription_params[:card_last4],
          card_brand: subscription_params[:card_brand]
      })
    end

    def subscription_params
      params.permit(:payment_token, :plan)
    end

    def customer_payload
      { source: subscription_params[:payment_token], email: current_user.email }
    end

    def subscription_payload(stripe_customer)
      { customer: stripe_customer.id, plan: subscription_params[:plan] }
    end

    def subscription_service
      SubscriptionService.new
    end
end
