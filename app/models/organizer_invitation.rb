class OrganizerInvitation < ActiveRecord::Base
  attr_accessible :conference_edition_id, :invitee_email, :invitee_id, :inviter_id, :token

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  # Validations
  validates :inviter_id, presence: true
  validates :invitee_email, presence: true, format: EMAIL_REGEX
  validates :conference_edition_id, presence: true
  validate :invitee_is_new

  # Callbacks
  before_create :generate_token

  private

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def invitee_is_new
    if conference_edition.organizers.find_by_email(invitee_email)
      errors.add :invitee_email, 'is invalid. There already an organizer with this email address'
    elsif conference_edition.organizer_invitations.find_by_invitee_email(invitee_email)
      errors.add :invitee_email, 'is invalid. He/she has already been invited'
    end
  end

end
