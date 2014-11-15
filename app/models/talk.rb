class Talk < ActiveRecord::Base
  has_and_belongs_to_many :speakers
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  has_many :talk_votes, dependent: :destroy
  has_one :slot

  VALID_STATUS_TRANSITIONS = {
    'confirmed' => ['cancelled'],
    'cancelled' => ['confirmed'],
    'approved' => ['pending', 'rejected', 'cancelled', 'confirmed'],
    'rejected' => ['approved', 'pending'],
    'pending' => ['approved', 'rejected']
  }
  STATUSES = VALID_STATUS_TRANSITIONS.keys

  # Validations
  validates :title, presence: true, uniqueness: { scope: :conference_edition_id }
  validates :abstract, presence: true
  validates :conference_edition_id, presence: true
  validates :language, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validate :status_transition_is_valid?, if: :status_changed?

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :title, :abstract

  accepts_nested_attributes_for :speakers

  # Scopes
  scope :by_creation_date, -> { order(created_at: :desc) }
  scope :by_ranking, -> { order('ranking DESC') }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :approved, -> { where(status: 'approved') }

  # Friendly ID
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders, :scoped], scope: :conference_edition_id

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def slug_candidates
    [
      :title,
      [:title, :speaker_names],
      [:title, :speaker_names, :id]
    ]
  end

  # Callbacks
  after_save :update_speaker_statuses, if: :status_changed?

  def update_speaker_statuses
    speakers.each do |speaker|
      statuses = speaker.talks.pluck(:status)

      speaker_status = if statuses.include?('confirmed')
        'confirmed'
      elsif statuses.include?('cancelled')
        'cancelled'
      elsif statuses.include?('approved')
        'approved'
      elsif statuses.include?('rejected')
        'rejected'
      else
        'pending'
      end

      speaker.update_columns(status: speaker_status)
    end
  end

  # Methods
  def to_s
    "'#{title}' by #{speakers.pluck(:name).to_sentence}"
  end

  def language_name
    Language.find(language).name
  end

  def language_code
    Language.find(language).code
  end

  def talk_vote_for_user(user)
    talk_votes.where(organizer_id: user.id).first.try(:vote)
  end

  private

  def status_transition_is_valid?
    if !new_record? && !VALID_STATUS_TRANSITIONS.fetch(status_was).include?(status)
      errors.add(:status, "can't transition from `#{status_was}` to `#{status}`")
      return false
    end
    true
  end

  def speaker_names
    speakers.map(&:name).join(' and ')
  end
end
