class FavoriteScreen < ApplicationRecord
  belongs_to :user
  belongs_to :screen

  validates :screen_id, uniqueness: { scope: :user_id }
end
