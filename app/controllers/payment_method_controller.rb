class PaymentMethodController < ApplicationController
  before_action :set_subscription, only: [:edit]

  def edit
    authorize @subscription
    @user = current_user
  end

  private

  def set_subscription
    @subscription ||= current_user.subscription
  end
end
