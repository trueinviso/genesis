class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    new_subscription_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
