class Subscriber < ActiveRecord::Base
  attr_accessible :conference_edition_id, :email

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :email, presence: true, format: EMAIL_REGEX
end
