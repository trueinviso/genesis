class Screen < ApplicationRecord
  include Filterable
  include Taggable

  belongs_to :category
  has_many :favorite_screens
  has_many :favorited_by, through: :favorite_screens, source: :user
  has_many :downloaded_screens
  has_many :downloaded_by, through: :downloaded_screens, source: :user
  has_one  :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true

  validates :category, presence: true
end
