class Slot < ActiveRecord::Base
  attr_accessible :from_datetime, :kind, :to_datetime, :conference_edition, :conference_edition_id

  belongs_to :conference_edition
  has_many :talks

  KINDS = %w( talk registration break lunch after_party )

  validates :from_datetime, presence: true
  validates :to_datetime, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

  default_scope order('from_datetime ASC')

  def to_s
    "#{from_datetime.to_s(:short)} - #{to_datetime.to_s(:short)}"
  end

  def time_to_s
    "#{from_datetime.strftime('%H:%M')} - #{to_datetime.strftime('%H:%M')}"
  end
end
