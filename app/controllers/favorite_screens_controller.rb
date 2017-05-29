class FavoriteScreensController < ApplicationController

  def index
    @favorite_screens = policy_scope(FavoriteScreen)
    authorize @favorite_screens
  end
end
