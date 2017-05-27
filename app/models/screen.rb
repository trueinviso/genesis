class Screen < ApplicationRecord
  include Filterable

  has_one  :picture, as: :imageable
  has_many :favorite_screens
  has_many :favorited_by, through: :favorite_screens, source: :user
  has_many :downloaded_screens
  has_many :downloaded_by, through: :downloaded_screens, source: :user
  accepts_nested_attributes_for :picture, allow_destroy: true
  acts_as_taggable

end
