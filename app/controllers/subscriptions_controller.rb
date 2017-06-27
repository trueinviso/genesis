class SubscriptionsController < ApplicationController

  skip_after_action :verify_authorized, only: [:new, :create]
  skip_before_action :verify_signed_in, only: [:new, :create]

  def new
    @subscription = Subscription.new
  end

  def create
    stripe_customer = find_or_create_customer
    current_user.update!({ stripe_id: stripe_customer.id })

    stripe_subscription = subscription_service.create_subscription(
      stripe_customer, subscription_payload(stripe_customer)
    )

    build_subscription(stripe_customer, stripe_subscription)

    redirect_to root_url
  end

  def destroy
    authorize Subscription
    subscription_service.cancel_subscription(current_user)
    subscription = current_user.subscription
    subscription.update!({ stripe_subscription_id: nil })
    sign_out current_user
    redirect_to new_user_session_path
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
      Subscription.find_or_initialize_by(user_id: current_user.id).update_attributes!(
          user: current_user,
          stripe_customer_id: stripe_customer.id,
          stripe_subscription_id: stripe_subscription.id,
          stripe_payment_token: stripe_customer.default_source,
          stripe_plan_id: stripe_subscription.plan.id,
          card_exp_month: subscription_params[:card_exp_month],
          card_exp_year: subscription_params[:card_exp_year],
          card_last4: subscription_params[:card_last4],
          card_brand: subscription_params[:card_brand]
      )
    end

    def subscription_params
      params.permit(:payment_token, :plan, :card_exp_month, :card_exp_year, :card_last4, :card_brand)
    end

    def customer_payload
      { email: current_user.email }
    end

    def subscription_payload(stripe_customer)
      { source: subscription_params[:payment_token], plan: subscription_params[:plan] }
    end

    def subscription_service
      SubscriptionService.new
    end
end
