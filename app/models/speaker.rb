class Speaker < ActiveRecord::Base
  attr_accessible :bio, :city, :company, :country, :email, :github_username, \
  :name, :talk, :talk_id, :twitter_username, :user_id, :talks, :avatar, \
  :avatar_cache, :translations_attributes, :conference_edition_id, \
  :is_confirmed, :job_title, :phone, :website, :lanyrd_username

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :user
  has_and_belongs_to_many :talks

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  # Validations
  validates :name, presence: true
  validates :avatar, presence: true, unless: :user_id?
  validates :email, presence: true, format: EMAIL_REGEX
  validates :twitter_username, presence: true

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :bio

  # Uploaders
  mount_uploader :avatar, ImageUploader

  # Scopes
  default_scope order('name ASC')
  scope :confirmed, -> { where(is_confirmed: true) }
end
