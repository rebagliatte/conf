class Talk < ActiveRecord::Base
  attr_accessible :abstract, :room, :room_id, :slides_url, :slot, :slot_id, :status, :title, :video_url, :speaker_ids, :speakers_attributes

  belongs_to :slot
  belongs_to :room
  has_and_belongs_to_many :speakers
  belongs_to :room

  STATUSES = %w( pending approved rejected )

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }

  translates :title, :abstract

  accepts_nested_attributes_for :speakers
end
