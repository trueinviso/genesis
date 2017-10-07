class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  layout "application"

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :verify_signed_in, unless: :devise_controller?
  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def verify_subscribed
    redirect_to(new_subscription_path) unless current_user_subscribed?
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || new_user_session_path)
  end

  def verify_signed_in
    if user_signed_in? && !current_user.subscribed?
      redirect_to new_subscription_path
    elsif !user_signed_in?
      redirect_to new_session_path
    end
  end

  def subscription_service
    SubscriptionService.new
  end
end
