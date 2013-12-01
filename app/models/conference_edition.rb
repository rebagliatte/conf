class ConferenceEdition < ActiveRecord::Base
  attr_accessible :from_date, :to_date, :kind, :promo_video_provider, :promo_video_uid, :status, :promo_image, \
  :logo, :conference, :conference_id, :translations_attributes, :tagline, :country, :city, :venue, \
  :sponsorship_packages_pdf, :registration_url

  belongs_to :conference
  has_many :posts, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :slots, dependent: :destroy
  has_many :speakers, dependent: :destroy
  has_many :sponsors, dependent: :destroy
  has_many :talks, dependent: :destroy
  has_many :languages, through: :conference

  KINDS = %w( single_track multiple_track )
  STATUSES = %w( coming_soon live sold_out past )
  VIDEO_PROVIDERS = %w( youtube vimeo )

  # Validations
  validates :from_date, presence: true
  validates :to_date, presence: true
  validates :logo, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :status, presence: true, inclusion: { in: STATUSES }

  with_options if: 'promo_video_uid.present?' do |c|
    c.validates :promo_video_provider, presence: true, inclusion: { in: VIDEO_PROVIDERS }
  end

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :tagline, :country, :city, :venue

  # Uploaders
  mount_uploader :logo, ImageUploader
  mount_uploader :promo_image, ImageUploader
  mount_uploader :sponsorship_packages_pdf, AttachmentUploader

  # Scopes
  default_scope order('from_date DESC')

  def previous_editions
    self.conference.conference_editions - [self]
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

  def to_s
    "#{conference.name} #{from_date.year}"
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
