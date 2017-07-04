class DownloadedScreen < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :screen, touch: true
end
