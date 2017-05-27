class SessionsController < ApplicationController
  # TODO: add the tests from the book for login
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.present? && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      user.admin? ? redirect_to admin_root_path : redirect_to root_path
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
