class UserController < ApplicationController
  def edit
    authorize User
    @user = current_user
  end

  def update
    authorize User
    @user = current_user
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password,
                                 :password_confirmation, :email,
                                 :send_product_updates, :send_new_screens_updates)
  end
end
