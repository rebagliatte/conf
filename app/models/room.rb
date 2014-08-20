class Room < ActiveRecord::Base
  has_many :talks
  belongs_to :conference_edition

  validates :name, presence: true
  validates :conference_edition_id, presence: true
end
