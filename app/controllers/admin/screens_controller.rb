module Admin
  class ScreensController < Admin::BaseController
    include ScreensHelper

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
        render "new"
      end
    end

    def edit
      authorize Screen
      @screen = Screen.find(params[:id])
    end

    def update
      authorize Screen
      @screen = Screen.find(params[:id])
      if @screen.update_attributes(screen_params)
        redirect_to admin_screens_path
      else
        render "edit"
      end
    end

    def show
      authorize Screen
      @screen = Screen.find(params[:id])
    end

    private

    def index_params
      params.permit(:search)
    end

    def screen_params
      params.require(:screen).permit(:category_id, :tag_list, picture_attributes: [:image])
    end
  end
end
