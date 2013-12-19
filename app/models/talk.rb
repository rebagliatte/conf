class Talk < ActiveRecord::Base
  attr_accessible :abstract, :room, :room_id, :slides_url, :slot, :slot_id, \
  :status, :title, :video_url, :speaker_ids, :speakers_attributes, \
  :conference_edition, :conference_edition_id, :translations_attributes, \
  :notes_to_organizers, :language

  belongs_to :slot
  belongs_to :room
  has_and_belongs_to_many :speakers
  belongs_to :room
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  STATUSES = %w( pending approved rejected )

  # Validations
  validates :title, presence: true, uniqueness: { scope: :conference_edition_id }
  validates :abstract, presence: true
  validates :conference_edition_id, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :language, presence: true

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :title, :abstract

  accepts_nested_attributes_for :speakers
end
