class OrganizerInvitation < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  # Validations
  validates :inviter_id, presence: true
  validates :invitee_email, presence: true, format: EMAIL_REGEX
  validates :conference_edition_id, presence: true
  validate :invitee_is_new, on: :create

  # Callbacks
  before_create :generate_token

  # Scopes
  scope :pending, { where(invitee_id: nil) }

  private

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def invitee_is_new
    if conference_edition.organizers.find_by(email: invitee_email)
      errors.add :invitee_email, "is invalid. There's already an organizer with this email address"
    elsif conference_edition.organizer_invitations.find_by(invitee_email: invitee_email)
      errors.add :invitee_email, 'is invalid. He/she has already been invited'
    end
  end
end
