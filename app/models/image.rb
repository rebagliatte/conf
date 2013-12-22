class Image < ActiveRecord::Base
  attr_accessible :conference_edition_id, :image

  belongs_to :conference_edition

  # Uploaders
  mount_uploader :image, ImageUploader
end
