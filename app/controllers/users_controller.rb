class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    byebug
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to new_subscription_path
    else
      @user.destroy
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :password,
                                   :password_confirmation, :email)
    end

    def customer_args
      OpenStruct.new({ email: user_params[:email] })
    end

end
