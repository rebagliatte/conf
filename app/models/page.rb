class Page < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  # Validations
  validates :title, presence: true, uniqueness: { scope: :conference_edition_id }
  validates :conference_edition_id, presence: true

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :title, :content

  # Friendly ID
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders, :scoped], scope: :conference_edition_id

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end
end
