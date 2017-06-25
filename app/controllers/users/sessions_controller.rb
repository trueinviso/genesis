class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in

  def new
    @login_path = true
    super
  end
end
