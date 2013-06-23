class Speaker < ActiveRecord::Base
  attr_accessible :bio, :city, :company, :country, :email, :github_username, :name, :talk, :talk_id, :twitter_username, :user_id, :talks, :avatar, :avatar_cache

  belongs_to :user
  has_and_belongs_to_many :talks

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :name, presence: true
  validates :avatar, presence: true, unless: :user_id?
  validates :email, presence: true, format: EMAIL_REGEX
  validates :twitter_username, presence: true

  mount_uploader :avatar, ImageUploader

  default_scope order('name ASC')
end
