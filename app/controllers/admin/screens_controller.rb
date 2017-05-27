class Admin::ScreensController < Admin::BaseController
  include ScreensHelper
  include SessionsHelper

  def index
    @screens = policy_scope(Screen).filter(index_params.slice(:search))
    authorize @screens
  end

  def new
    authorize Screen
    @screen = Screen.new
    @screen.build_picture
  end

  def create
    authorize Screen
    @screen = Screen.new(screen_params)
    if @screen.save
      redirect_to admin_root_url
    else
      render 'new'
    end
  end

  private

    def index_params
      params.permit(:search)
    end

    def screen_params
      params.require(:screen).permit(:image_link, picture_attributes: [ :image ] )
    end
end
