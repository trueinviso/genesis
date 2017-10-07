class UsersController < ApplicationController
  def edit
    authorize User
    @user = User.find(current_user.id)
  end

  def edit_subscription
    authorize User
    @user = current_user
  end

  def edit_payment_method
    authorize User
    @user = current_user

    respond_to do |format|
      format.js
    end
  end

  def notifications
    authorize User
    @user = User.find(current_user.id)

    respond_to do |format|
      format.js
    end
  end

  def update
    authorize User
    @user = User.find(current_user.id)
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
