class Image < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  MAX_IMAGES_PER_EDITION = 10

  # Validations
  validates :image, presence: true, file_size: { maximum: 0.5.megabytes.to_i }
  validate :edition_images_length

  def edition_images_length
    message = "can't be more than #{MAX_IMAGES_PER_EDITION} for a given conference edition."
    if conference_edition.images.length > MAX_IMAGES_PER_EDITION
      errors.add(:images, message)
    end
  end

  # Uploaders
  mount_uploader :image, ImageUploader
end
