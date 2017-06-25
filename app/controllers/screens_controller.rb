class ScreensController < ApplicationController
  include ScreensHelper

  def index
    @screens = policy_scope(Screen).filter(index_params.slice(:tag_name, :category_name))
    @tags = get_tag_list(index_params[:category_name]) if index_params[:category_name].present?
    authorize @screens
  end

  def search
    @screens = policy_scope(Screen).filter(search_params.slice(:search))
    authorize @screens
  end

  def show
    authorize Screen
    @screen = Screen.find(params[:id])
  end

  private

  def index_params
    params.permit(:tag_name, :category_name)
  end

  def search_params
    params.permit(:search)
  end
end
