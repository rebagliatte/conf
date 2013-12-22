class Image < ActiveRecord::Base
  attr_accessible :conference_edition_id, :image

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  # Validations
  validates :image, presence: true

  # Uploaders
  mount_uploader :image, ImageUploader
end
