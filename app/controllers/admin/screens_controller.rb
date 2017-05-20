class Admin::ScreensController < Admin::BaseController
  include ScreensHelper
  include SessionsHelper

  def index
    @screens = policy_scope(Screen).filter(index_params.slice(:search))
    authorize @screens
  end

  def new
    @screen = screen.new
  end

  def create
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
      params.require(:screen).permit(:image_url, :s3_url)
    end
end
