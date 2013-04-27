class Talk < ActiveRecord::Base

  attr_accessible :description, :room, :slides_url, :slot, :status, :title, :video_url

  belongs_to :slot
  belongs_to :room
  has_many :speakers
  belongs_to :room

  STATES = %w( pending approved rejected )

  validates :title, presence: true
  validates :status, inclusion: { in: STATES }

end
