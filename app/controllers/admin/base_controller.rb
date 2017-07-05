class Admin::BaseController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  after_action :verify_authorized
  before_action :require_login

  #layout 'admin'

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    # Override pundit methods to namespace policies in admin
    def authorize(record, query = nil)
      super([:admin, record], query)
    end

    def policy_scope(scope)
      super([:admin, scope])
    end
    ###########################

    def require_login
      unless user_signed_in? && current_user.role?(:admin)
        redirect_to root_path
      end
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
