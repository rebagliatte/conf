class User < ActiveRecord::Base
  attr_accessor :internal_authentication

  has_many :identities, dependent: :destroy
  has_one :speaker
  has_and_belongs_to_many :manageable_editions, class_name: 'ConferenceEdition'
  has_many :owned_conferences, class_name: 'Conference', foreign_key: :owner_id

  ROLES = %w( user admin )
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  MIN_PASSWORD_LENGTH = 6

  # Rails secure password
  has_secure_password validations: false

  # Validations
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX, if: :internal_authentication
  validates :password, presence: true, length: { minimum: 6 }, if: :internal_authentication
  validates :role, inclusion: { in: ROLES }
  validates :image, file_size: { maximum: 0.5.megabytes.to_i }, if: :image_changed?

  # Uploaders
  mount_uploader :image, ImageUploader

  def admin?
    self.role == 'admin'
  end

  def has_internal_authentication?
    !password_digest.blank?
  end

  def manageable_edition_ids
    @manageable_edition_ids ||= manageable_editions.pluck(:id)
  end

  def readable_conference_ids
    @readable_conference_ids ||= manageable_editions.pluck(:conference_id).uniq
  end

  def self.create_with_omniauth(info)
    create!(
      name: info['name'],
      nickname: info['nickname'],
      email: info['email'],
      image: info['image'],
      internal_authentication: false
    )
  end
end
