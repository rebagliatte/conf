class ConferenceEdition < ActiveRecord::Base

  attr_accessible :name, :description, :venue, :kind, :promotional_video_url

  has_many :sponsors
  has_many :slots
  has_many :posts

  KINDS = %w( single_track multiple_track )

  validates :name, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

end
