class Subscriber < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  validates :email, presence: true, format: EMAIL_REGEX

  def self.to_csv(options = {})
    all.pluck(:email).join("\n")
  end

  # Scopes
  default_scope { order(created_at: :desc) }
end
