class Page < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  # Validations
  validates :title, presence: true
  validates :conference_edition_id, presence: true

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :title, :content
end
