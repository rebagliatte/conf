class Notification < ActiveRecord::Base
  attr_accessible :conference_edition_id, :organizer_id, :recipients, \
  :recipient_emails, :subject, :body, :translations_attributes

  RECIPIENTS = %w(subscribers approved_speakers rejected_speakers)

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :organizer, class_name: 'User'

  # Validations
  validates :conference_edition_id, presence: true
  validates :subject, presence: true
  validates :body, presence: true
  validates :recipients, presence: true

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :subject, :body

  def recipient_emails
    recipients = case recipients.to_sym
            when :subscribers
              conference_edition.subscribers
            when :approved_speakers
              conference_edition.speakers.approved
            when :rejected_speakers
              conference_edition.speakers.rejected
            end

    recipients.pluck(:email).join(',')
  end
end
