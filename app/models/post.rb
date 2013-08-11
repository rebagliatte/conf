class Post < ActiveRecord::Base
  attr_accessible :body, :conference_edition, :conference_edition_id, :image, :summary, :title, :translations_attributes

  belongs_to :conference_edition

  # Validations
  validates :title, presence: true
  validates :conference_edition_id, presence: true

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :title, :summary, :body

  # Uploaders
  mount_uploader :image, ImageUploader

  # Scopes
  default_scope order('created_at DESC')
end
