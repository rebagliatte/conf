class Talk < ActiveRecord::Base
  attr_accessible :description, :room, :room_id, :slides_url, :slot, :slot_id, :status, :title, :video_url, :speakers_attributes

  belongs_to :slot
  belongs_to :room
  has_many :speakers
  belongs_to :room

  STATUSES = %w( pending approved rejected )

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }

  accepts_nested_attributes_for :speakers
end
