class Sponsor < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  has_many :sponsor_contacts, dependent: :destroy

  KINDS = {
    platinum: 1,
    gold: 2,
    silver: 3,
    bronze: 4,
    media_partner: 5
  }

  # Validations
  validates :name, presence: true, uniqueness: { scope: :conference_edition_id }
  validates :logo, presence: true, file_size: { maximum: 0.5.megabytes.to_i }, if: :logo?
  validates :website_url, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS.keys.map(&:to_s) }

  # Translations
  has_many :translations
  accepts_nested_attributes_for :translations
  translates :description

  # Uploaders
  mount_uploader :logo, ImageUploader

  # Scopes
  default_scope { order(name: :asc) }

  # Instance methods
  def contribution_level
    KINDS[kind.to_sym]
  end
end
