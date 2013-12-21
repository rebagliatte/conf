class Subscriber < ActiveRecord::Base
  attr_accessible :conference_edition_id, :email

  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :email, presence: true, format: EMAIL_REGEX
end
