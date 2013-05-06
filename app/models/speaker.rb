class Speaker < ActiveRecord::Base
  attr_accessible :bio, :city, :company, :country, :email, :github_username, :name, :talk, :talk_id, :twitter_username

  belongs_to :talk

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :name, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :twitter_username, presence: true
end
