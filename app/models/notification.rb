class Notification < ActiveRecord::Base
  attr_accessible :conference_edition_id, :organizer_id, :recipients, \
  :recipient_emails, :subject, :body, :translations_attributes, :sent_at

  INTERPOLABLE_VARIABLES = {
    subscribers: %w(email),
    approved_speakers: %w(email name company selected_talk_title),
    confirmed_speakers: %w(email name company selected_talk_title),
    rejected_speakers: %w(email name company)
  }
  RECIPIENTS = INTERPOLABLE_VARIABLES.keys
  INTERPOLABLE_VARS_REGEX = /{{\s?([\w\W]+?)\s?}}/

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :organizer, class_name: 'User'

  # Validations
  validates :conference_edition_id, presence: true
  validates :subject, presence: true
  validates :body, presence: true
  validates :recipients, presence: true
  validate :translations_presence
  validate :recipients_presence
  validate :interpolable_variables_correctness

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :subject, :body

  # Instance methods
  def recipient_users
    case recipients.to_sym
    when :subscribers
      conference_edition.subscribers
    when :approved_speakers
      conference_edition.speakers.approved
    when :rejected_speakers
      conference_edition.speakers.rejected
    when :confirmed_speakers
      conference_edition.speakers.confirmed
    end
  end

  private

  # Custom validations

  def translations_presence
    if translations.size != conference_edition.languages.count
      errors.add(:base, "it seems you've missed some translations")
    end
  end

  def recipients_presence
    if !recipient_users.any?
      errors.add(:base, "no recipients match this criteria")
    end
  end

  def interpolable_variables_correctness
    full_content = ''
    conference_edition.languages.each do |language|
      lang = language.code.to_sym
      full_content += "#{subject(lang)} #{body(lang)} "
    end
    matches = full_content.scan(INTERPOLABLE_VARS_REGEX).flatten

    matches.each do |match|
      if !INTERPOLABLE_VARIABLES[recipients.to_sym].include?(match)
        errors.add(:body, "'#{match}' is not an available variable for this kind of recipient")
      end
    end
  end
end
