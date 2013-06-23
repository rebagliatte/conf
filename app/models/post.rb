class Post < ActiveRecord::Base
  attr_accessible :body, :conference_edition, :conference_edition_id, :image, :summary, :title, :translations_attributes

  belongs_to :conference_edition
  has_many :translations

  accepts_nested_attributes_for :translations
  translates :title, :summary, :body

  validates :title, presence: true
  validates :conference_edition_id, presence: true

  mount_uploader :image, ImageUploader

  default_scope order('created_at DESC')
end
