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

  def self.tag_name(tag_name)
    includes(:picture, :favorite_screens, :downloaded_screens).joins(:tags).where('tags.name = :tag_name', tag_name: tag_name)
  end

  def self.category_name(category_name)
    joins(:category).where('categories.name = :category_name', category_name: category_name)
  end

  def self.search(search)
    joins(:tags, :category).where('categories.name ILIKE :search OR ' \
                                  'tags.name ILIKE :search', search: "%#{search}%")
  end
end
