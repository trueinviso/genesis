class FavoriteScreen < ApplicationRecord
  belongs_to :user
  belongs_to :screen
end
