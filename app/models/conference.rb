class Conference < ActiveRecord::Base
  attr_accessible :email, :facebook_page_username, :name, :twitter_hashtag, :twitter_username, :subdomain, :conference_editions_attributes

  has_many :conference_editions

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true, length: { maximum: 60 }
  validates :email, presence: true, format: EMAIL_REGEX

  accepts_nested_attributes_for :conference_editions
end
