class Code < ActiveRecord::Base
  belongs_to :conference_edition
  has_one :conference, through: :conference_edition

  # Constants
  MAX_DISCOUNT = 100

  # Validations
  validates :code, presence: true, uniqueness: { scope: :conference_edition }
  validates :conference_edition, presence: true
  validates :discount, presence: true, numericality: {
    less_than: MAX_DISCOUNT,
    greater_than: 0,
    only_integer: true
  }
end
