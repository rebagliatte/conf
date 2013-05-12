class Sponsor < ActiveRecord::Base
  attr_accessible :description, :name, :kind, :conference_edition, :conference_edition_id, :logo

  belongs_to :conference_edition

  KINDS = %w( platinum gold silver bronze media_partner )

  validates :name, presence: true, uniqueness: {scope: :conference_edition_id}
  validates :logo, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

  mount_uploader :logo, ImageUploader
end
