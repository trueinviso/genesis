class DownloadedScreensController < ApplicationController
  def index
    @downloaded_screens = policy_scope(DownloadedScreen)
    authorize @downloaded_screens
  end

  def create
    authorize DownloadedScreen
    screen = Screen.find params[:id]
    DownloadedScreen.where(user_id: current_user.id, screen_id: params[:id]).first_or_create!
    send_file screen.sketch_file.file.download.path
  end
end
