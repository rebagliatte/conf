class Ticket < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  # Validations
  validates :name, presence: true, uniqueness: { scope: :conference_edition }
  validates :conference_edition, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
