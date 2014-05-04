class SponsorContact < ActiveRecord::Base
  attr_accessible :conference_edition_id, :sponsor_id, :language, \
  :language_id, :name, :email

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition
  belongs_to :sponsor
  belongs_to :language

  # Validations
  validates :sponsor, presence: true
  validates :language, presence: true
  validates :name, presence: true
  validates :email, presence: true
end
