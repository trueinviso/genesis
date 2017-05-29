class DownloadedScreensController < ApplicationController

  def index
    @downloaded_screens = policy_scope(DownloadedScreen)
    authorize @downloaded_screens
  end
end
