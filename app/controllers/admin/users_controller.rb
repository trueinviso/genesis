class Admin::UsersController < Admin::BaseController
  include UsersHelper
  include SessionsHelper

  def index
    @users = policy_scope(User).filter(index_params.slice(:search))
    authorize @users
  end

  def new
    @user = User.new
    @user.profile = Profile.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_root_url
    else
      @user.destroy if @user.valid?
      render 'new'
    end
  end

  private

    def index_params
      params.permit(:search)
    end

    def payment_token
      params.permit(:payment_token)['payment_token']
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                   :terms_and_conditions,
                                   :profile_attributes => [:first_name, :last_name],
                                   :user_plan_attributes => [:plan]
                                  )
    end
end
