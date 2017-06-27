class FavoriteScreensController < ApplicationController

  def index
    @favorite_screens = policy_scope(FavoriteScreen)
    authorize @favorite_screens
  end

  def create
    authorize FavoriteScreen
    FavoriteScreen.where(user_id: current_user.id, screen_id: params[:id]).first_or_create!
    redirect_to screens_path
  end
end
