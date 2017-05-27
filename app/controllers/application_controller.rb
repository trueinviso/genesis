class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :require_login

  layout 'application'

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def require_login
      return
      unless logged_in? # && current_user.active_subscription?
        redirect_to login_path
      end
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def subscription_service
      SubscriptionService.new
    end
end
