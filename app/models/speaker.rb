class Speaker < ActiveRecord::Base

  attr_accessible :description, :email, :github_username, :name, :talk, :twitter_username

  belongs_to :talk

  validates :name, presence: true
  validates :email, presence: true
  validates :twitter_username, presence: true

end
