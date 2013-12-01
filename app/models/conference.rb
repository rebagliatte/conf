class Conference < ActiveRecord::Base
  attr_accessible :email, :facebook_page_username, :name, :twitter_hashtag, :twitter_username, :subdomain, :owner_id, \
  :conference_editions_attributes, :language_ids

  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :organizers, class_name: 'User'
  has_and_belongs_to_many :languages
  has_many :conference_editions, dependent: :destroy

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  # Validations
  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true, length: { maximum: 60 }
  validates :owner, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :languages, presence: true

  accepts_nested_attributes_for :conference_editions
end
