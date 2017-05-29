class ScreensController < ApplicationController

  def index
    @screens = policy_scope(Screen).filter(index_params.slice(:search))
    @categories = Category.all
    authorize @screens
  end

  def show
    authorize Screen
    @screen = Screen.find(params[:id])
  end

  private

    def index_params
      params.permit(:search)
    end
end
