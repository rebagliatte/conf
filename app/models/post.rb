class Post < ActiveRecord::Base

  attr_accessible :body, :conference_edition_id, :summary, :title

  belongs_to :conference_edition

  validates :title, presence: true
  validates :conference_edition_id, presence: true

end
