class Talk < ActiveRecord::Base
  attr_accessible :description, :room, :room_id, :slides_url, :slot, :slot_id, :status, :title, :video_url

  belongs_to :slot
  belongs_to :room
  has_many :speakers
  belongs_to :room

  STATUSES = %w( pending approved rejected )

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }

  def speaker_names
    speakers = self.speakers

    if speakers.count == 1
      speakers.first.name
    else
      speakers.map(&:name).to_sentence
    end
  end
end
