class Speaker < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :user
  has_and_belongs_to_many :talks

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  STATUSES = Talk::STATUSES

  # Validations
  validates :name, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :website, format: URL_REGEX, if: :website?
  validates :avatar, file_size: { maximum: 0.5.megabytes.to_i }, if: :avatar?
  validates :status, inclusion: { in: STATUSES }

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :bio

  # Uploaders
  mount_uploader :avatar, ImageUploader

  # Scopes
  default_scope { order(name: :asc) }
  scope :promoted, -> { where(is_promoted: true) }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :approved, -> { where(status: 'approved') }
  scope :rejected, -> { where(status: 'rejected') }

  # Instance Methods
  def is_travelling?
    status == 'confirmed' && country != conference_edition.country
  end

  def selected_talk_title
    (talks.approved.first || talks.confirmed.first).try(:title)
  end
end
