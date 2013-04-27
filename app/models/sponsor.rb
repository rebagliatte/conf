class Sponsor < ActiveRecord::Base

  attr_accessible :description, :name, :kind, :conference_edition_id

  belongs_to :conference_edition

  KINDS = %w( platinum gold silver bronze media_partner )

  validates :name, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

end
