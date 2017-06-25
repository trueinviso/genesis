class UsersController < ApplicationController

  def edit
    authorize User
    @user = User.find(current_user.id)
  end

  def edit_subscription
    authorize User
    @user = current_user
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
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to edit_user_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password,
                                   :password_confirmation, :email)
  end
end
