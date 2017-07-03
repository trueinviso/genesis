class SketchFile < ApplicationRecord
  include FileUploader::Attachment.new(:file)
  belongs_to :design, polymorphic: true, optional: true
end
