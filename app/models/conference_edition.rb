class ConferenceEdition < ActiveRecord::Base
  attr_accessible :conference_year, :description, :country, :city, :venue, :kind, :promotional_video_url, :status

  has_many :sponsors
  has_many :slots
  has_many :posts

  KINDS = %w( single_track multiple_track )
  STATUSES = %w( past present future )

  validates :conference_year, presence: true, uniqueness: true
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :status, presence: true, inclusion: { in: STATUSES }

  def self.current_edition
    # Current edition, wether it's present or future
    self.where('status != ?', 'past').last
  end

  def self.previous_editions
    self.where(status: 'past')
  end

  def present?
    self.status == 'present'
  end

  def future?
    self.status == 'future'
  end
end
