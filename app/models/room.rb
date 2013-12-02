class Room < ActiveRecord::Base
  attr_accessible :name, :conference_edition_id

  has_many :talks
  belongs_to :conference_edition

  validates :name, presence: true
  validates :conference_edition_id, presence: true
end
