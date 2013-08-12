class Sponsor < ActiveRecord::Base
  attr_accessible :name, :kind, :conference_edition, :conference_edition_id, :logo, :website_url, :translations_attributes, :description

  belongs_to :conference_edition

  KINDS = %w( platinum gold silver bronze media_partner )

  # Validations
  validates :name, presence: true, uniqueness: {scope: :conference_edition_id}
  validates :logo, presence: true
  validates :website_url, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :description

  # Uploaders
  mount_uploader :logo, ImageUploader
end
