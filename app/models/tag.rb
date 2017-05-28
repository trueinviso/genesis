class Tag < ApplicationRecord
  has_many :taggings
  has_many :screens, through: :taggings
end
