class Picture < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :imageable, polymorphic: true, optional: true
end
