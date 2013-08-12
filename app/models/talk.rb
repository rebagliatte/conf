class Talk < ActiveRecord::Base
  attr_accessible :abstract, :room, :room_id, :slides_url, :slot, :slot_id, :status, :title, :video_url, :speaker_ids, :speakers_attributes, :conference_edition, :conference_edition_id, :translations_attributes

  belongs_to :slot
  belongs_to :room
  has_and_belongs_to_many :speakers
  belongs_to :room
  belongs_to :conference_edition

  STATUSES = %w( pending approved rejected )

  # Validations
  validates :title, presence: true, uniqueness: { scope: :conference_edition_id }
  validates :abstract, presence: true
  validates :conference_edition_id, presence: true
  validates :status, inclusion: { in: STATUSES }

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :title, :abstract

  accepts_nested_attributes_for :speakers
end
