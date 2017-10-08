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
    CreateSubscription.for(current_user, subscription_params)
    redirect_to root_url
  end

  def update
    authorize @subscription
    SubscriptionService.update_card(current_user, update_params) if update_params[:payment_token]
    SubscriptionService.update_subscription(current_user.subscription, update_params)
    redirect_to root_path
  end

  def destroy
    authorize @subscription
    SubscriptionService.cancel_subscription(current_user)
    sign_out current_user
    redirect_to new_user_session_path
  end

  private

  def set_subscription
    @subscription ||= current_user.subscription
  end

  def subscription_params
    params.permit(
      :payment_token, :plan, :card_exp_month,
      :card_exp_year, :card_last4, :card_brand
    )
  end

  def update_params
    params.permit(
      :card_last4, :card_exp_month, :card_exp_year,
      :card_brand, :payment_token,
      user: [:email, subscription_attributes: [:stripe_plan_id, :id]]
    )
  end
end
