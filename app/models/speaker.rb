class Speaker < ActiveRecord::Base
  attr_accessible :bio, :city, :company, :country, :email, :github_username, \
  :name, :talk, :talk_id, :twitter_username, :user_id, :talks, :avatar, \
  :avatar_cache, :translations_attributes, :conference_edition_id, \
  :status, :job_title, :phone, :website, :lanyrd_username

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :user
  has_and_belongs_to_many :talks

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  URL_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  # Validations
  validates :name, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :website, format: URL_REGEX, if: :website?
  validates :avatar, file_size: { maximum: 0.5.megabytes.to_i }, if: :avatar?

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :bio

  # Uploaders
  mount_uploader :avatar, ImageUploader

  # Scopes
  default_scope order('name ASC')
  scope :approved, -> { where(status: 'approved') }
  scope :rejected, -> { where(status: 'rejected') }
end
