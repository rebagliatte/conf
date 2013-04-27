class Slot < ActiveRecord::Base

  attr_accessible :from, :kind, :to, :conference_edition

  belongs_to :conference_edition
  has_many :talks

  KINDS = %w( talk registration break lunch after_party )

  validates :from, presence: true
  validates :to, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

end
