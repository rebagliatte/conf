class ConferenceEdition < ActiveRecord::Base

  attr_accessible :name, :description, :venue, :kind, :promotional_video_url, :status

  has_many :sponsors
  has_many :slots
  has_many :posts

  KINDS = %w( single_track multiple_track )
  STATUSES = %w( past current future )

  validates :name, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :status, presence: true, inclusion: { in: STATUSES }

end
