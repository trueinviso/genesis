class SubscriptionController < ApplicationController
  skip_after_action :verify_authorized, only: [:new, :create]
  skip_before_action :verify_signed_in, only: [:new, :create]
  before_action :set_subscription, only: [:edit, :update, :destroy]

  def new
    @subscription = Subscription.new
  end

  def edit
    authorize @subscription
    @user = current_user
  end

  def create
    stripe_customer = find_or_create_customer
    current_user.update!({ stripe_id: stripe_customer.id })

    stripe_subscription = subscription_service.create_subscription(
      stripe_customer, subscription_payload
    )

    build_subscription(stripe_customer, stripe_subscription)

    redirect_to root_url
  end

  def update
    authorize @subscription
    subscription_service.update_card(current_user, update_params)
    subscription_service.update_subscription(current_user.subscription, update_params)
    redirect_to root_path
  end

  def destroy
    authorize @subscription
    subscription_service.cancel_subscription(current_user)
    sign_out current_user
    redirect_to new_user_session_path
  end

  private

  def set_subscription
    @subscription ||= current_user.subscription
  end

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
      card_brand: subscription_params[:card_brand],
    )
  end

  def subscription_params
    params.permit(:payment_token, :plan, :card_exp_month, :card_exp_year, :card_last4, :card_brand)
  end

  def update_params
    params.permit(
      :card_last4, :card_exp_month, :card_exp_year, :card_brand, :payment_token,
      user: [:email, subscription_attributes: [:stripe_plan_id, :id]]
    )
  end

  def customer_payload
    { email: current_user.email }
  end

  def subscription_payload
    { source: subscription_params[:payment_token], plan: subscription_params[:plan] }
  end

  def subscription_service
    SubscriptionService.new
  end
end
