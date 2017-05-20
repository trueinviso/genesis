class Admin::BaseController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper
  include Pundit


  before_filter :require_login

  layout 'admin'

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def require_login
      unless logged_in? && current_user.admin?
        redirect_to login_path
      end
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
