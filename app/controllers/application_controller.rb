class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Pundit
  include ApplicationHelper

  layout 'application'

  after_action :verify_authorized
  before_action :require_login

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def require_login
      unless logged_in?
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
