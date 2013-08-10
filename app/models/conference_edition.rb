class ConferenceEdition < ActiveRecord::Base
  attr_accessible :from_date, :to_date, :tagline, :country, :city, :venue, :kind, :promo_video_provider, :promo_video_uid, :status, :promo_image, :logo, :conference, :conference_id

  belongs_to :conference
  has_many :sponsors
  has_many :posts
  has_many :slots
  has_many :talks, through: :slots
  has_many :speakers, through: :talks
  has_many :languages, through: :conference

  KINDS = %w( single_track multiple_track )
  STATUSES = %w( coming_soon live sold_out past )
  VIDEO_PROVIDERS = %w( youtube vimeo )

  validates :from_date, presence: true
  validates :to_date, presence: true
  validates :logo, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :status, presence: true, inclusion: { in: STATUSES }

  with_options if: 'promo_video_uid.present?' do |c|
    c.validates :promo_video_provider, presence: true, inclusion: { in: VIDEO_PROVIDERS }
  end

  mount_uploader :logo, ImageUploader
  mount_uploader :promo_image, ImageUploader

  default_scope order('from_date DESC')

  def self.previous_editions
    self.where(status: 'past').order('from_date').reverse
  end

  def coming_soon?
    self.status == 'coming_soon'
  end

  def live?
    self.status == 'live'
  end

  def multiple_track?
    self.kind == 'multiple_track'
  end

  def grouped_slots
    # Slots grouped by date
    self.slots.order('from_datetime').group_by { |s| s.from_datetime.beginning_of_day }
  end

  def grouped_sponsors
    # Sponsors grouped by kind
    self.sponsors.group_by { |s| s.kind }
  end

  def max_simultaneous_talks_count
    max_simultaneous_talks_count = 0

    self.slots.each do |s|
      slot_talks_count = s.talks.count
      if slot_talks_count > max_simultaneous_talks_count
        max_simultaneous_talks_count = slot_talks_count
      end
    end

    max_simultaneous_talks_count
  end
end
