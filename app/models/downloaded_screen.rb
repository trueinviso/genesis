class DownloadedScreen < ApplicationRecord
  belongs_to :user
  belongs_to :screen
end
