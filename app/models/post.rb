class Post < ActiveRecord::Base
  attr_accessible :body, :conference_edition, :conference_edition_id, :image, :summary, :title

  default_scope order('created_at DESC')

  belongs_to :conference_edition

  validates :title, presence: true
  validates :conference_edition_id, presence: true

  mount_uploader :image, ImageUploader
end
