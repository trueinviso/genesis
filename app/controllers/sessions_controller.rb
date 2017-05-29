class SessionsController < ApplicationController
  # TODO: add the tests from the book for login

  skip_before_action :require_login, only: [:new, :create]
  skip_after_action :verify_authorized

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.present? && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      if user.admin?
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def letsencrypt
    render text: 'A8PC8A8VkQlYSGUFnD7IO_DVAOIh124sNnPw-Ph8HNQ'
  end
end
