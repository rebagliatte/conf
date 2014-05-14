class Slot < ActiveRecord::Base
  attr_accessible :day, :start_time, :end_time, :kind, :conference_edition, \
  :conference_edition_id, :talk, :talk_id, :room_id

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :room
  belongs_to :talk

  KINDS = %w( talk registration break lunch after_party lightning_talks )

  # Validations
  validates :day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :room_id, presence: true, if: :belongs_to_multi_track_conference?
  validate :valid_datetime_range
  validate :valid_talk

  # Scopes
  default_scope order('start_time ASC')

  # Instance methods
  def is_talk_slot?
    kind == 'talk'
  end

  def belongs_to_multi_track_conference?
    conference_edition.multiple_track?
  end

  def taken_talks_ids
    @taken_talks_ids ||= (conference_edition.slots - [self]).map(&:talk_id)
  end

  private

  def valid_datetime_range
    if !(start_time < end_time)
      errors.add(:start_time, 'must be before end time')
      errors.add(:end_time, 'must be after start time')
    end

    if !conference_edition.event_dates.include?(day)
      errors.add(:base, 'time range must be included in the current edition dates')
    end
  end

  def valid_talk
    if is_talk_slot?
      if !talk_id
        errors.add(:talk, 'must be present on talk slots')
      elsif taken_talks_ids.include?(talk_id)
        errors.add(:talk, 'is already taken')
      end
    elsif talk_id
      errors.add(:talk, "must be blank for #{kind} slots")
    end
  end
end
